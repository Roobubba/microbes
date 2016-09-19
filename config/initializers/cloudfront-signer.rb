if Rails.env.production?
  Aws::CF::Signer.configure do |config|
    #config.key_path = '/path/to/keyfile.pem'
    config.key = ENV["CF_PRIVATE_KEY"]
    config.key_pair_id  = ENV["CF_ACCESS_KEY"]
    config.default_expires = 3600
  end
end
