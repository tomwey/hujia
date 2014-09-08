# coding: utf-8
class Coach < ActiveRecord::Base
  attr_accessible :city,:province, :company, :image, :image_crop_x,:image_crop_y,:image_crop_w,:image_crop_h,
  :photos_attributes, :is_authorized, :price, :intro, :star_count, :drive_type, :coupons_attributes, :service_area_ids, :teach_location, :is_check, :location, :mobile, :pickup_location, :qq, :real_name, :service_type, :sex, :image_cache
  
  validates :mobile, format: { with: /\A1[3|4|5|8][0-9]\d{4,8}\z/, message: "请输入11位正确手机号" }, length: { is: 11 }, 
            :presence => true, :uniqueness => true
  validates :qq, :format => { :with => /[1-9][0-9]{4,}/, :message => "请输入正确的QQ号" }, :uniqueness => true
  
  has_one :user, as: :profile, dependent: :destroy
  
  has_many :coupons, as: :ownerable, dependent: :destroy
  accepts_nested_attributes_for :coupons
  
  has_many :comments, as: :commentable
  
  has_many :photos, as: :photoable, dependent: :destroy
  accepts_nested_attributes_for :photos, reject_if: Proc.new { |attr| attr['image'].blank? }, :allow_destroy => true
  
  has_and_belongs_to_many :service_areas, :class_name => "College"
  
  mount_uploader :image, AvatarUploader
  crop_uploaded  :image
  
  def check_image_blank
    self[:image].blank?
  end
  
  def self.search(keyword)
    if keyword
      where('real_name LIKE ? or company LIKE ?', "%#{keyword}%", "%#{keyword}%")
    else
      scoped
    end
  end
end
