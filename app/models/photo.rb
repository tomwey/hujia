class Photo < ActiveRecord::Base
  belongs_to :photoable
  attr_accessible :image, :sort, :image_cache
  
  mount_uploader :image, PhotoUploader
end
