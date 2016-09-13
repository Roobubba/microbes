module MicrobeHelper

  
  def get_microbes_belonging_to(user)
    microbe_int = user.microbes
    microbe_hash = Hash.new
    microbe_hash["MICROBES"] = user.microbes.to_s
    i = 0
    while ((2 ** i) <= microbe_int)
      microbe = Microbe.find(i)
      if (has_microbe(microbe))
        microbe_hash["MICROBEWINDOWSHASH-" + i.to_s] = microbe.attachment_fingerprint.to_s
        microbe_hash["MICROBEANDROIDHASH-" + i.to_s] = microbe.androidattachment_fingerprint.to_s
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