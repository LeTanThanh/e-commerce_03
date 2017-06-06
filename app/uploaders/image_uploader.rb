class ImageUploader < CarrierWave::Uploader::Base
  storage :file

  def default_url *args
    ActionController::Base.helpers.asset_path("fallback/" +
      [version_name, "no_picture_available.jpg"].compact.join('_'))
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
