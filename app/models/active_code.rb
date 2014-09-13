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
    
    content_tpl = SiteConfig.send_sms_tpl
    content = content_tpl.gsub(/{code}/, self.code)
    content = content.gsub(/{name}/, self.user.profile.try(:real_name))
    content = content.gsub(/{mobile}/, self.user.profile.try(:mobile))
    
    if is_send.to_i != 0
      puts 'start send sms...'
      if mobile.to_s.length != 11
        mobile = self.coupon.ownerable.mobile
      end
      RestClient.post(SiteConfig.send_sms_uri, "userid=#{user_id}&account=#{account}&password=#{password}&mobile=#{mobile}&content=#{content}") { |response, request, result, &block|
        puts result
      }
    end
    
  end
  
end
