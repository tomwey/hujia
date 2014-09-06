class College < ActiveRecord::Base
  attr_accessible :name, :city_id
  
  validates :name, :city_id, :presence => true
  
  validates_uniqueness_of :name
  
  belongs_to :city
end
