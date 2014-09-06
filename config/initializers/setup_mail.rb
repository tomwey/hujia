ActionMailer::Base.delivery_method = :sendmail 
ActionMailer::Base.smtp_settings = { 
  :address => 'localhost', 
  :domain => 'mail.hujia361.com', 
  :port => 25 
} 