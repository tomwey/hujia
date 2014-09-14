# coding: utf-8
class ActiveCode < ActiveRecord::Base
  attr_accessible :actived_at, :code, :coupon_id, :user_id
  
  # validates :code, :user_id, :presence => true
  
  belongs_to :coupon
  belongs_to :user
  
  before_create :generate_code
  def generate_code
    begin
      self[:code] = rand.to_s[2..11]
    end while ActiveCode.exists?(:code => self[:code])
  end
  
  after_create :send_sms
  def send_sms
    
    sms_config = SiteConfig.send_sms
    is_send, user_id, account, password, mobile = sms_config.split(',')
    
    if is_send.to_i != 0
      puts 'start send sms...'
      
      if self.user.blank? or self.user.profile.blank? or self.user.profile.mobile.blank?
        return
      end
      
      if mobile.to_s.length != 11
        mobile = self.coupon.ownerable.mobile
      end
      
      content_tpl = SiteConfig.send_sms_tpl
      content = content_tpl.gsub(/{code}/, self.code)
      content = content.gsub(/{name}/, self.user.profile.try(:real_name))
      content = content.gsub(/{mobile}/, self.user.profile.try(:mobile))
      
      # 给教练发短信
      RestClient.post(SiteConfig.send_sms_uri, "userid=#{user_id}&account=#{account}&password=#{password}&mobile=#{mobile}&content=#{content}") { |response, request, result, &block|
        puts result
      }
      
      if self.coupon.blank? or self.coupon.ownerable.blank?
        return
      end
      
      content2 = "您领取的代金券号为：#{self.coupon.id}，教练的电话号码：#{self.coupon.ownerable.mobile}"
      # 给用户发短信
      RestClient.post(SiteConfig.send_sms_uri, "userid=#{user_id}&account=#{account}&password=#{password}&mobile=#{self.user.profile.try(:mobile)}&content=#{content2}") { |response, request, result, &block|
        puts result
      }
      
    end
    
  end
  
end
