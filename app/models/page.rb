class Page < ActiveRecord::Base
  attr_accessible :body, :slug, :title, :sort
  
  validates :body, :title, :slug, :presence => true
  
  scope :recent, order('sort DESC')
end
