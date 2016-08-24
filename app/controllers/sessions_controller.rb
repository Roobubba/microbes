class SessionsController < ApplicationController

  skip_before_filter  :verify_authenticity_token, only: [:game, :testing]

  def new
    redirect_to login_url.to_s
  end

  def game
    client = get_new_client(params['code'])
    user = login_or_create_user(client)
    send_data user.microbes, type: 'text/plain; charset=UTF-8', disposition: 'inline'
  end

  def create
    client = get_new_client(params['code'])
    login_or_create_user(client)
    
    # Redirect home
    #TODO For my application, if they try to access locked-down functionality while not signed in, the app saves the URL to the session and redirects them there; if not, it just redirects them to the home page:
    redirect_to session[:redirect_to] ||= root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end