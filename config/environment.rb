# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  user_name:      Rails.application.credentials.sendgrid[:username],
  password:       Rails.application.credentials.sendgrid[:password],
  domain:         Rails.application.credentials.sendgrid[:email],
  address:        "smtp.sendgrid.net",
  port:            587,
  authentication: :plain
}
