class ActiveCode < ActiveRecord::Base
  attr_accessible :actived_at, :code, :coupon_id, :user_id
  
  # validates :code, :user_id, :presence => true
  
  belongs_to :coupon
  
  before_create :generate_code
  def generate_code
    begin
      self[:code] = rand.to_s[2..11]
    end while ActiveCode.exists?(:code => self[:code])
  end
  
end
