class Appointment < ActiveRecord::Base
  belongs_to :user
  belongs_to :appointable, :polymorphic => true
  # attr_accessible :title, :body
  
  scope :recent, order('created_at desc')
  
  def coupon
    return false if appointable.blank?
    @coupon ||= Coupon.where(:ownerable_type => self.appointable.class, :ownerable_id => self.appointable.id).first
  end
  
end
