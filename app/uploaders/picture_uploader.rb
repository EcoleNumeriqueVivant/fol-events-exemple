# encoding: utf-8

class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  if Rails.env.staging? || Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def default_url
    ActionController::Base.helpers.asset_path('avatar-default.jpg')
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :resize_to_fill => [300, 300]

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end