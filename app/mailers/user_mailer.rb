class UserMailer < ApplicationMailer
  default from: "notifications-noreply@bullishhunter.com"
  layout "mailer"

  def welcome_email
    @user_name = params[:user][:user]
    @email_address = params[:user][:email]
    mail(to: @email_address, subject: 'Welcome to Bullish Hunter')
  end
end
