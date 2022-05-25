class UserNotifierMailer < ApplicationMailer
  require 'sendgrid-ruby'
  include SendGrid
  default :from => 'Świat Zabawek <shu-han@llinformatics.com>'

  # send a signup email to the user, pass in the user object that contains the user's email address
  def send_signup_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Thanks for signing up for Świat Zabawek Store' )
  end
end

