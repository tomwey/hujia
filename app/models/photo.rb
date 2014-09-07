class Photo < ActiveRecord::Base
  belongs_to :photoable
  attr_accessible :image, :sort
  
  mount_uploader :image, PhotoUploader
end
