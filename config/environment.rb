# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  user_name:      'apikey',
  password:        Rails.application.credentials.sendgrid[:api_key],
  domain:         "shu-han@llinformatics.com",
  address:        "smtp.sendgrid.net",
  port:            587,
  authentication: :plain
}
ActionMailer::Base.default_options = {
  from: "Świat Zabawek <shu-han@llinformatics.com>"
}