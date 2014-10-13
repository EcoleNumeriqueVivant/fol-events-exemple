CarrierWave.configure do |config|
  config.fog_credentials = Gaston.carrierwave.fog_credential.symbolize_keys
  config.fog_directory   = Gaston.carrierwave.fog_directory
  config.fog_attributes  = {'Cache-Control' => 'max-age=315576000'}
end
