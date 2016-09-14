if Rails.env.production?
  CarrierWave.configure do |config|
    config.storage = :aws
    config.aws_credentials = {
    #:provider => 'AWS',
    :access_key_id => ENV['S3_ACCESS_KEY'],
    :secret_access_key => ENV['S3_SECRET_KEY'],
    :region => ENV['S3_REGION']
    }
    
    config.aws_bucket = ENV['S3_BUCKET']
    config.aws_acl = :public_read
    #config.fog_directory = ENV['S3_BUCKET']
    #config.fog_public = false
  end
end