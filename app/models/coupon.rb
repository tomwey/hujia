# coding: utf-8
class Coupon < ActiveRecord::Base
  attr_accessible :code, :image, :title, :subtitle, :publish_count, :ownerable_id, :ownerable_type, :user_id, :value, :start_date, :end_date

  belongs_to :ownerable, :polymorphic => true
  
  belongs_to :user
  
  has_many :active_codes, :dependent => :destroy
  
  validates :value, :publish_count, :start_date, :end_date, :presence => true
  
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
  
end
