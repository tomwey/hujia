# coding: utf-8
class City < ActiveRecord::Base
  belongs_to :province
  attr_accessible :code, :name, :province_id
  
  validates :name, :code, presence: true, uniqueness: true
  validates :province_id, presence: true
  
  validates :code, :format => { :with => /\d/, :message => "必须是由数字组成" }, length: { is: 6 }
  
  has_many :colleges
end
