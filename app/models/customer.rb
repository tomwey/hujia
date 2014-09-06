# coding: utf-8
class Customer < ActiveRecord::Base
  attr_accessible :mobile, :real_name, :id_number, :qq, :is_student, :college, :province, :city
  
  has_one :user, as: :profile, dependent: :destroy
  
  validates :mobile, :format => { :with => /\A1[3|4|5|8][0-9]\d{4,8}\z/, :message => '请输入11位正确手机号'}, 
            :length => { :is => 11 }, :uniqueness => true, :if => :check_mobile_not_blank?
  
  validates :id_number, :format => { :with => /\d{15}|\d{18}/, :message => '请输入15位或18位正确身份证号'}, :uniqueness => true, :if => :check_id_number_not_blank?
  
  validates :qq, :format => { :with => /[1-9][0-9]{4,}/, :message => '请输入正确的QQ号' }, :uniqueness => true, :presence => true#, :if => :not_new_record
  
  # validates :real_name, :presence => true, :if => :not_new_record
                      
  validates :college, :presence => true, :if => :check_is_student?
  validates :province, :presence => true, :if => :check_is_student?
  validates :city, :presence => true, :if => :check_is_student?
  
  before_create :check_is_student
  def check_is_student
    if is_student == false
      self.college = nil
      self.province = nil
      self.city = nil
    end
  end
  
  def check_is_student?
    is_student == true
  end
  
  def check_mobile_not_blank?
    not mobile.blank? or not new_record?
  end
  
  def check_id_number_not_blank?
    not id_number.blank?
  end
  
end
