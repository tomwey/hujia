# coding: utf-8
require "digest/md5"
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :nickname, :user_type
  # attr_accessible :title, :body
  # attr_accessible :nickname#, :real_name, :mobile, :city, :location
  
  attr_accessor :login
  attr_accessible :login
  
  has_many :appointments, :dependent => :destroy
  # has_many :coupons, :dependent => :destroy
  
  has_many :coupon_schools, :class_name => "School", :uniq => true,
  :through => :coupons, :source => :ownerable, :source_type => :school
  
  has_many :comments
  
  # 领取
  has_many :vouchings
  # 领取的代金券
  has_many :voucher_coupons, through: :vouchings, class_name: "Coupon", :source_type => :coupon
  
  belongs_to :profile, polymorphic: true
  
  # validates :nickname, :email, :presence => true
  validates :email, :password, :password_confirmation, :presence => true
  validates :nickname, :format => { :with => /\A\w+\z/, :message => '只允许数字、大小写字母和下划线'}, 
            :length => { :in => 3..20 }, :presence => true, :uniqueness => { :case_sensitive => false }
            
            
  
  def email_required?
      false
  end
    
  def password_required?
      false
  end
   
  # 重写devise认证
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(nickname) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
  
  # 注册邮件提醒
  after_create :send_welcome_mail
  def send_welcome_mail
    BaseMailer.welcome(self).deliver
  end
  
  def update_with_password(params={})
    if !params[:current_password].blank? or !params[:password].blank? or !params[:password_confirmation].blank?
      super
    else
      params.delete(:current_password)
      self.update_without_password(params)
    end
  end
  
  def has_actived_code?
    ActiveCode.where(:user_id => self.id).count > 0
  end
  
  def appoint(appointable)
    Appointment.where(:appointable_id => appointable.id,
                      :appointable_type => appointable.class,
                      :user_id => self.id).first_or_create
  end
  
  def unappoint(appointable)
    Appointment.destroy_all(:appointable_id => appointable.id,
                            :appointable_type => appointable.class,
                            :user_id => self.id)
  end
  
  def super_admin?
    self.email == 'tomwey@163.com'
  end
  
  def admin?
    
    if SiteConfig.admin_emails
      flag = SiteConfig.admin_emails.split(",").include?(self.email)
    else
      flag = false
    end
    
    self.super_admin? or flag
  end
  
  def coach?
    self.profile_type == 'Coach'
  end
  
  def school?
    self.profile_type == 'School'
  end
  
  def update_private_token
    random_key = "#{SecureRandom.hex(10)}:#{self.id}"
    self.update_attribute(:private_token, random_key)
  end
  
  def ensure_private_token!
    self.update_private_token if self.private_token.blank?
  end
  
end
