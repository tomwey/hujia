# coding: utf-8
class School < ActiveRecord::Base
  attr_accessible :city, :image, :intro,:drive_type,:star_count, :coupons_attributes, :service_type, :is_3a, :is_check, :teach_location, :linkman, :price, :location, :mobile, :name, :phone, :qq, :website, :zcode, :image_cache
  
  has_one :user, as: :profile, dependent: :destroy
  
  has_many :coupons, as: :ownerable, dependent: :destroy
  accepts_nested_attributes_for :coupons
  
  # has_many :appointments, as: :appointable, dependent: :destroy
  # has_many :appointers, :class_name => "User", :through => :appointments, :source => :user
  
  has_many :comments, as: :commentable
  
  validates :name, :linkman, :presence => true
  validates :mobile, :format => { :with => /\A1[3|4|5|8][0-9]\d{4,8}\z/, :message => "请输入11位正确手机号" }, :length => { :is => 11 }, :presence => true, :uniqueness => true
  validates :qq, :format => { :with => /[1-9][0-9]{4,}/, :message => "请输入正确的QQ号" }, :uniqueness => true
  validates :phone, :format => { :with => /\d{3}-\d{8}|\d{4}-\d{7}/, :message => "请输入正确的电话号码" }, :uniqueness => true
  validates :zcode, :format => { :with => /[1-9]\d{5}(?!\d)/, :message => "请输入正确的邮编" }
  
  validates :terms_of_service, acceptance: true
  
  validates :price, :presence => true
  
  mount_uploader :image, ImageUploader
  
end
