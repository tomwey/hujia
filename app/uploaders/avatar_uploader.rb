# encoding: utf-8

class AvatarUploader < BaseUploader

  version :normal do
    process :resize_to_fill => [48, 48]
  end
  
  version :thumb do
    process crop: :image
    resize_to_limit(164,164)
  end
  
  version :small, from_version: :thumb do
    # process :resize_to_fill => [16,16]
    resize_to_limit(50, 50)
  end
  
  version :large do
    resize_to_limit(300, 300)
    # process :resize_to_fill => [64,64]
  end
  
  version :big do
    process :resize_to_fill => [120,120]
  end
  
  def filename
    if super.present?
      "avatar/#{Time.now.to_i}.#{file.extension.downcase}"
    end
  end
  
end
