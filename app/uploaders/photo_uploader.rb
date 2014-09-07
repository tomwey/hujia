# encoding: utf-8

class PhotoUploader < BaseUploader

  version :normal do
    process :resize_to_fill => [48, 80]
  end
  
  version :small do
    process :resize_to_fill => [50,50]
  end
  
  version :large do
    process :resize_to_fill => [346,346]
  end
  
  version :big do
    process :resize_to_fill => [120,150]
  end
  
  def filename
    if super.present?
      @name ||= Digest::MD5.hexdigest(File.dirname(current_path))
      "#{@name}.#{file.extension.downcase}"
    end
  end
  
end
