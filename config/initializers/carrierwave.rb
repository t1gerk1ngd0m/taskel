CarrierWave.configure do |config|
  if Rails.env.production?
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_S3_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_S3_SECRET_ACCESS_KEY'],
      region: ENV['AWS_REGION']
    }
    config.fog_directory  = 'taskel-file'
  else
    config.storage :file
    config.enable_processing = false if Rails.env.test?
  end
end
