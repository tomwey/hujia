# encoding: utf-8

class ImageUploader < BaseUploader

  version :normal do
    process :resize_to_fill => [48, 80]
  end
  
  version :small do
    process :resize_to_fill => [24,40]
  end
  
  version :large do
    process :resize_to_fill => [64,96]
  end
  
  version :big do
    process :resize_to_fill => [120,150]
  end
  
  def filename
    if super.present?
      "image/#{Time.now.to_i}.#{file.extension.downcase}"
    end
  end
  
end
