class College < ActiveRecord::Base
  attr_accessible :name, :city_id, :sort
  
  validates :name, :city_id, :presence => true
  
  validates_uniqueness_of :name
  
  belongs_to :city
  
  scope :sorted, lambda { order('sort asc') }  
end
