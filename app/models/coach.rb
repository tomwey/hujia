# coding: utf-8
class Coach < ActiveRecord::Base
  attr_accessible :city, :company, :image, :price, :intro, :star_count, :drive_type,:coupons_attributes, :service_area_ids, :teach_location, :is_check, :location, :mobile, :pickup_location, :qq, :real_name, :service_type, :sex, :image_cache
  
  has_one :user, as: :profile, dependent: :destroy
  
  has_many :coupons, as: :ownerable, dependent: :destroy
  accepts_nested_attributes_for :coupons
  
  has_many :comments, as: :commentable
  
  validates :mobile, :format => { :with => /\A1[3|4|5|8][0-9]\d{4,8}\z/, :message => "请输入11位正确手机号" }, :length => { :is => 11 }, :presence => true, :uniqueness => true
  validates :qq, :format => { :with => /[1-9][0-9]{4,}/, :message => "请输入正确的QQ号" }, :uniqueness => true
  
  mount_uploader :image, AvatarUploader
  
  has_and_belongs_to_many :service_areas, :class_name => "College"
  
  SERVICE_TYPES = [['不接送', '不接送'], ['教练接送', '教练接送'],['班车接送', '班车接送']]
  
  def self.search(search)
    if search
      where('real_name LIKE ? or company LIKE ?', "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end
end
