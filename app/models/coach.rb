# coding: utf-8
class Coach < ActiveRecord::Base
  attr_accessible :city,:province, :company, :image, :image_crop_x,:image_crop_y,:image_crop_w,:image_crop_h,:fee_intro, :note,:payment_type,
  :photos_attributes, :is_authorized, :price, :intro, :star_count, :drive_type, :coupons_attributes, :service_area_ids, :teach_location, :is_check, :location, :mobile, :pickup_location, :qq, :real_name, :service_type, :sex, :image_cache
  
  attr_protected :visible
  
  validates :mobile, format: { with: /\A1[3|4|5|8][0-9]\d{4,8}\z/, message: "请输入11位正确手机号" }, length: { is: 11 }, 
            :presence => true, :uniqueness => true
  validates :qq, :format => { :with => /[1-9][0-9]{4,}/, :message => "请输入正确的QQ号" }, :uniqueness => true
  
  validates :city, :province, :company, :image, :fee_intro, :price, :intro, :is_authorized, :star_count, :drive_type, 
  :teach_location, :is_check, :location, :real_name, :service_type, :service_area_ids, :payment_type, :coupons, :photos, presence: true
  
  has_one :user, as: :profile, dependent: :destroy
  
  has_many :coupons, as: :ownerable, dependent: :destroy
  accepts_nested_attributes_for :coupons
  
  has_many :comments, as: :commentable
  has_many :rating_scores, :foreign_key => "comment_id"
  
  has_many :photos, as: :photoable, dependent: :destroy
  accepts_nested_attributes_for :photos, reject_if: Proc.new { |attr| attr['image'].blank? }, :allow_destroy => true
  
  has_and_belongs_to_many :service_areas, :class_name => "College"
  
  mount_uploader :image, AvatarUploader
  # crop_uploaded  :image
  
  scope :visibled, lambda { where(:visible => true) }
  scope :needed_fields, lambda { select('real_name, company, image') }
  scope :hot, lambda { order("coaches.sort ASC, coupons.claims_count DESC, comments_count DESC, coaches.price ASC, coaches.created_at DESC") }
  
  def check_image_blank
    self[:image].blank?
  end
  
  def total_user_count_for(level)
    case level
    when 5 then @total5 ||= self.rating_scores.where(:score => 5.0).count
    when 4 then @total4 ||= self.rating_scores.where('score >= 4.0 and score < 5.0').count
    when 3 then @total3 ||= self.rating_scores.where('score >= 3.0 and score < 4.0').count
    when 2 then @total2 ||= self.rating_scores.where('score >= 2.0 and score < 3.0').count
    when 1 then @total1 ||= self.rating_scores.where('score >= 1.0 and score < 2.0').count
    else 0
    end
  end
  
  def self.search(keyword)
    if keyword
      where('real_name LIKE ? or company LIKE ?', "%#{keyword}%", "%#{keyword}%")
    else
      scoped
    end
  end
end
