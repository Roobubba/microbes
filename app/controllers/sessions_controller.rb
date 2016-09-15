class SessionsController < ApplicationController

  skip_before_filter :verify_authenticity_token, only: [:game, :testing]

  def new
    redirect_to login_url.to_s
  end

  def game
    if (params['code'] == 'testing')
      testing(params['plat'])
    else
      client = get_new_client(params['code'])
      user = login_or_create_user(client)
      microbes = get_microbes_belonging_to(user, params['plat'])
      send_data microbes.to_xml, type: 'text/plain; charset=UTF-8', disposition: 'inline'
    end
  end

  def testing(platform)
    user = User.first
    microbe_int = user.microbes
    microbe_hash = Hash.new
    microbe_hash["MICROBES"] = user.microbes.to_s
    i = 0
    while ((2 ** i) <= microbe_int)
      microbe = Microbe.find(i)
      if (test_has_microbe(microbe, user))
        
        if (platform == "Windows")
          microbe_hash["HASH-" + i.to_s] = microbe.attachment_fingerprint.to_s
          url = microbe.attachment.presigned_url(:get, expires_in: 1*20.minutes)
        elsif (platform == "Android")
          microbe_hash["HASH-" + i.to_s] = microbe.androidattachment_fingerprint.to_s
          url = microbe.androidattachment.presigned_url(:get, expires_in: 1*20.minutes)
        end
        microbe_hash["Test1-" + i.to_s] = url
        
        microbe_hash["Test2-" + i.to_s] = url.to_s
        microbe_hash["DYNLINK-" + i.to_s] = url

        #microbe_hash["VERSION-" + i.to_s] = microbe.microbe_hash.to_s
        microbe_hash["FILENAME-" + i.to_s] = microbe.link.to_s
        microbe_hash["NAME-" + i.to_s] = microbe.name.to_s
        microbe_hash["FULLNAME-" + i.to_s] = microbe.fullname.to_s
        microbe_hash["MORPHOLOGY-" + i.to_s] = Morphology.find(microbe.morphology_id).morphology.to_s
      end
      i+=1
    end
    send_data microbe_hash.to_xml, type: 'text/plain; charset=UTF-8', disposition: 'inline'
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

  private 
  
  def test_has_microbe(microbe, user)
    true if ((user.microbes.to_i & (2 ** (microbe.id.to_i))) == (2 ** (microbe.id.to_i)))
  end

end