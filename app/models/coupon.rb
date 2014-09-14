# coding: utf-8
class Coupon < ActiveRecord::Base
  attr_accessible :code, :image, :title, :subtitle, :publish_count, :ownerable_id, :ownerable_type, :value, :start_date, :end_date

  belongs_to :ownerable, :polymorphic => true
  
  has_many :active_codes, :dependent => :destroy
  has_many :vouchings
  
  validates :value, :publish_count, :start_date, :end_date, :title, :subtitle, :presence => true
  
  validates :value, :publish_count, :format => { :with => /\d/ }, :numericality => { :greater_than => 0 }
  
  validate :end_date_greater_than_start_date
  def end_date_greater_than_start_date
    if start_date >= end_date
      errors.add(:start_date, "必须小于结束日期")
    end
  end
  
  def active
    self.class.increment_counter(:actives_count, self.id)
  end
  
  def add_visit
    self.class.increment_counter(:claims_count, self.id)
  end
  
  def vouched_by_user?(user)
    Vouching.where(:coupon_id => self.id, :user_id => user.id ).count > 0
  end
  
end
