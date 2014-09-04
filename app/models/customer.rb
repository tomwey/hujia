# coding: utf-8
class Customer < ActiveRecord::Base
  attr_accessible :mobile, :real_name, :id_number, :qq, :is_student, :college
  
  has_one :user, as: :profile, dependent: :destroy
  
  validates :mobile, :format => { :with => /\A1[3|4|5|8][0-9]\d{4,8}\z/, :message => '请输入11位正确手机号'}, 
            :length => { :is => 11 }, :presence => true, :uniqueness => true, :if => :not_new_record
  
  validates :id_number, :format => { :with => /\d{15}|\d{18}/, :message => '请输入15位或18位正确身份证号'}, :presence => true, :uniqueness => true, :if => :not_new_record
  
  validates :qq, :format => { :with => /[1-9][0-9]{4,}/, :message => '请输入正确的QQ号' }, :uniqueness => true, :if => :not_new_record
  
  validates :real_name, :presence => true, :if => :not_new_record
                      
  validates :college, :presence => true, :if => :check_is_student?
  
  def check_is_student?
    is_student == true
  end
  
  def not_new_record
    not new_record?
  end
  
end
