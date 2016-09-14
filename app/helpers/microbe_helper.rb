module MicrobeHelper

  def get_new_aws_resource_url(file)
    aws_resource = Aws::S3::Resource::new(
      :access_key_id => ENV['S3_ACCESS_KEY'],
      :secret_access_key => ENV['S3_SECRET_KEY'],
      :region => ENV['S3_REGION'])
    aws_resource.bucket(ENV['S3_BUCKET']).object(file).presigned_url(:get, expires_in: 1*20.minutes)
  end
  
  def get_microbes_belonging_to(user, platform)
    microbe_int = user.microbes
    microbe_hash = Hash.new
    microbe_hash["MICROBES"] = user.microbes.to_s
    i = 0
    while ((2 ** i) <= microbe_int)
      microbe = Microbe.find(i)
      if (has_microbe(microbe))

        if (platform == "Windows")
          microbe_hash["HASH-" + i.to_s] = microbe.attachment_fingerprint.to_s
          url_b = microbe.attachment.url.to_s
        elsif (platform == "Android")
          microbe_hash["HASH-" + i.to_s] = microbe.androidattachment_fingerprint.to_s
          url_b = microbe.androidattachment.url.to_s
        end
        
        if Rails.env.production?
          url = get_new_aws_resource_url(url_b).to_s
        else
          url = URI.join(request.url, url_b).to_s
        end
        
        microbe_hash["DYNLINK-" + i.to_s] = url.to_s  
        #microbe_hash["VERSION-" + i.to_s] = microbe.microbe_hash.to_s
        microbe_hash["FILENAME-" + i.to_s] = microbe.link.to_s
        microbe_hash["NAME-" + i.to_s] = microbe.name.to_s
        microbe_hash["FULLNAME-" + i.to_s] = microbe.fullname.to_s
        microbe_hash["MORPHOLOGY-" + i.to_s] = Morphology.find(microbe.morphology_id).morphology.to_s
      end
      i+=1
    end
    microbe_hash
  end
  
  def can_afford(microbe)
    true if microbe.cost <= current_user.currency
  end
  
  def has_microbe(microbe)
    true if ((current_user.microbes.to_i & (2 ** (microbe.id.to_i))) == (2 ** (microbe.id.to_i)))
  end
  
end