# LawWenda::Application.configure do
  # config.action_mailer.delivery_method = Settings.email.delivery_method.to_sym
  # delivery_settings_key = "#{Settings.email.delivery_method}_settings"
  # if delivery_settings = Settings.email[delivery_settings_key]
  #   config.action_mailer.send "#{delivery_settings_key}=", delivery_settings.symblize_keys
  # end
  # 
  # config.action_mailer.default_url_options = {
  #   :host => Settings.email.host
  # }
  # 
  # ActionMailer::Base.default :from => Settings.email.from
# end
ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => Settings.domain,
  :user_name            => Settings.email_sender,
  :password             => Settings.email_password,
  :authentication       => "plain",
  :enable_starttls_auto => true
}

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default_url_options[:host] = Settings.domain