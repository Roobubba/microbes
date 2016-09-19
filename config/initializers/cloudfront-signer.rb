if Rails.env.production?
  Aws::CF::Signer.configure do |config|
    #config.key_path = '/path/to/keyfile.pem'
    config.key = ENV.fetch('CF_PRIVATE_KEY') # key_path not required if key supplied directly
    config.key_pair_id  = ENV.fetch('S3_ACCESS_KEY') #documentation unclear as to what this should be (ie there isn't any doc on this)
    config.default_expires = 3600
  end
end