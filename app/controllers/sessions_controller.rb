class SessionsController < ApplicationController

  skip_before_filter  :verify_authenticity_token, only: [:create]

  def new
    redirect_to login_url.to_s
  end

  def create
    
    client = get_new_client(params['code'])
    if !client.access_token or !valid_token?(client.access_token)
      access_token = client.fetch_access_token!
    else
      access_token = client.access_token
    end
    
    
    # Get user tokens from GoogleHelper
    refresh_token = client.refresh_token

    
    # Get the username from Google
    google_app_id = ApplicationController::GOOGLE_APP_ID
    user_id = call_api('/games/v1/applications/' + google_app_id + '/verify/', access_token['access_token'])
    
    #client = call_api('/oauth2/v4/token', user_tokens['access_token'])
    
    #user_info = client.player_id #call_api('/oauth2/v4/token', user_tokens['access_token'])
    #@text = user_info['player_id']
    
    user = User.find_by(:uniqueid => user_id['player_id'])#user_info['id']).first
    # Create the user if they don't exist
    #FIX THESE FIELDS TO WHAT WE WANT ONLY
    if(user == nil)
      user = User.create(:uniqueid => user_id['player_id'], :refresh_token => refresh_token, :access_token => access_token['access_token'])
      session[:user_id] = user.id
    else
      user.update(:access_token => access_token['access_token'])
      session[:user_id] = user.id
    end
    
    # Redirect home
    #TODO For my application, if they try to access locked-down functionality while not signed in, the app saves the URL to the session and redirects them there; if not, it just redirects them to the home page:
    redirect_to session[:redirect_to] ||= root_path
  
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end