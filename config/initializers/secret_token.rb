# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.

# require 'securerandom'
# 
# def secure_token
#   token_file = Rails.root.join('.secret')
#   if File.exist?(token_file)
#     File.read(token_file).chomp
#   else
#     token = SecureRandom.hex(64)
#     File.write(token_file, token)
#     token
#   end
# end

HujiaWebsite::Application.config.secret_token = Settings.secret_token#secure_token #'2ba07192c1f2b3d88f528b35efd6a4a430fd7c875fd731e0358f3d715d83080f6111004deda609fe8b2976e05c02e0e229dee30259776cc87b5bb8c0305edbe9'
