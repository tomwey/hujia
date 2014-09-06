class City < ActiveRecord::Base
  belongs_to :province
  attr_accessible :code, :name, :province_id
  
  has_many :colleges
end
