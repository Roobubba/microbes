module MicrobeHelper

  def get_new_aws_resource_url(file)
    Aws::CF::Signer.sign_url("https://dxu41j7h325w.cloudfront.net/" + file)
    #aws_resource = Aws::S3::Resource::new(
    #  :access_key_id => ENV['S3_ACCESS_KEY'],
    #  :secret_access_key => ENV['S3_SECRET_KEY'],
    #  :region => ENV['S3_REGION'])
    #aws_resource.bucket(ENV['S3_BUCKET']).object(file).presigned_url(:get, expires_in: 1*20.minutes)
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
          url = CGI.unescape(get_new_aws_resource_url(microbe.attachment.path))
        elsif (platform == "Android")
          microbe_hash["HASH-" + i.to_s] = microbe.androidattachment_fingerprint.to_s
          url = CGI.unescape(get_new_aws_resource_url(microbe.androidattachment.path))
        end

        microbe_hash["DYNLINK-" + i.to_s] = url
        #microbe_hash["VERSION-" + i.to_s] = microbe.microbe_hash.to_s
        microbe_hash["FILENAME-" + i.to_s] = microbe.link.to_s
        microbe_hash["NAME-" + i.to_s] = microbe.name.to_s
        microbe_hash["FULLNAME-" + i.to_s] = microbe.fullname.to_s
        microbe_hash["MORPHOLOGY-" + i.to_s] = Morphology.find(microbe.morphology_id).morphology.to_s
        microbe_hash["GRAM-" + i.to_s] = microbe.gram_status.to_s
        microbe_hash["NUMGENES-" + i.to_s] = microbe.number_genes.to_s
        microbe_hash["PATHOGENIC-" + i.to_s] = microbe.pathogenic.to_s
        microbe_hash["DIMENSIONS-" + i.to_s] = microbe.dimensions.to_s
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