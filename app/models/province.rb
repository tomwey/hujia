# coding: utf-8
class Province < ActiveRecord::Base
  attr_accessible :name, :code
  
  validates :name, :code, presence: true, uniqueness: true
  
  validates :code, :format => { :with => /\d/, :message => "必须是由数字组成" }, length: { is: 6 }
  
  has_many :cities
  
  def sorted_cities
    self.cities
  end
end
