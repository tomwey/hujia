# coding: utf-8
class BaseMailer < ActionMailer::Base
  default :from => "U驾网 <no-reply@hujia361.com>"
  default :charset => "utf-8"
  default :content_type => "text/html"
  default_url_options[:host] = Settings.domain
  
  def welcome(target)
    @target = target
    return false if @target.blank?
    mail to: @target.email, subject: "欢迎加入护驾网"
  end
end