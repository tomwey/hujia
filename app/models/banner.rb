# coding: utf-8
class Banner < ActiveRecord::Base
  attr_accessible :screenshot, :sort, :summary, :title, :url, :visible
  
  validates :screenshot, :url, :title, :summary, :sort, :presence => true
  
  validates :sort, :format => { :with => /\d+/, :message => "必须是数字" }
  
  mount_uploader :screenshot, ScreenshotUploader
  
  scope :visibled, lambda { where(:visible => true) }
  scope :sorted, lambda { order('sort DESC') }
  
end
