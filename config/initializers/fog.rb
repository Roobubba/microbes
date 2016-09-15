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
    config.aws_acl = :private
    config.aws_authenticated_url_expiration = 600
    config.aws_attributes = {
      expires: 1.week.from_now.httpdate,
      cache_control: 'max-age=604800'
    }

  end
end