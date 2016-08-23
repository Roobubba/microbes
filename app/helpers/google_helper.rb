module GoogleHelper

  def login_url

    client = Signet::OAuth2::Client.new(
    :authorization_uri => 'https://accounts.google.com/o/oauth2/auth',
    :token_credential_uri => 'https://www.googleapis.com/oauth2/v4/token',
    :client_id => ENV["GOOGLE_CLIENT_ID"],
    :client_secret => ENV["GOOGLE_SECRET"],
    :scope => ApplicationController::GOOGLE_SCOPE,
    :redirect_uri => ApplicationController::BASEURL + 'oauth2gcallback',
    :additional_parameters => {"access_type" => "offline"}
    )
    client.authorization_uri

  end
  
  def get_new_client(code)

    client_info = {
      :client_id => ENV["GOOGLE_CLIENT_ID"],
      :client_secret => ENV["GOOGLE_SECRET"],
      :redirect_uri => ApplicationController::BASEURL + 'oauth2gcallback',
      :code => code,
      :token_credential_uri => 'https://www.googleapis.com/oauth2/v4/token',
      :grant_type => 'authorization_code',
      :authorization_uri => 'https://accounts.google.com/o/oauth2/auth',
      :additional_parameters => {"access_type" => "offline"}
    }
    client = Signet::OAuth2::Client.new(client_info)

  end
  
  def call_api(path, access_token)

    #client_info = {
    #  :client_id => ENV["GOOGLE_CLIENT_ID"],
    #  :client_secret => ENV["GOOGLE_SECRET"],
    #  :token_credential_uri => 'https://www.googleapis.com/auth/games',
    #  :redirect_uri => ApplicationController::BASEURL + 'oauth2gcallback',
    #  :access_token => access_token
    #}
    #client = Signet::OAuth2::Client.new(client_info) #access_token: access_token)
    #game = Google::Apis::GamesV1::GamesService.new
    #game.authorization = client
    #player = game.verify_application(ENV["GOOGLE_APP_ID"])
    
    #player.playerId.to_s
    url = URI.parse('https://www.googleapis.com')
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE # You should use VERIFY_PEER in production
    
    # Make request to API
    request = Net::HTTP::Get.new(path)
    request['Authorization'] = 'OAuth ' + access_token
    response = http.request(request)
    JSON.parse(response.body)

  end
  
  
  def valid_token?(access_token)

    path = '/oauth2/v3/tokeninfo'
    
    url = URI.parse('https://www.googleapis.com')
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE # You should use VERIFY_PEER in production
  
    # Make request to API
    request = Net::HTTP::Get.new(path)
    request['Authorization'] = 'Bearer ' + access_token.to_s
    response = http.request(request)
  
    result = JSON.parse(response.body)
  
    if(result['error'] != nil && result['error'] == 'invalid_token')
      false
    else
      true
    end
  end
  
  def refresh_token(user_id)

    user = User.find(user_id)
  
    params['refresh_token'] = user.refresh_token
    params['client_id'] = ApplicationController::GOOGLE_CLIENT_ID
    params['client_secret'] = ApplicationController::GOOGLE_SECRET
    params['grant_type'] = 'refresh_token'
  
    # Initialize HTTP library
    url = URI.parse('https://accounts.google.com')
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE # You should use VERIFY_PEER in production

    # Make request for tokens
    request = Net::HTTP::Post.new('/o/oauth2/token')
    request.set_form_data(params)
    response = http.request(request)
  
    # Parse the response
    user_tokens = JSON.parse(response.body)
  
    # Save the new access_token to the user 
    user.access_token = user_tokens['access_token']
    #user.expires_at = user_tokens['expires_in']
    user.save
  
    # Return the new access_token
    user_tokens['access_token']
  
  end
  
end