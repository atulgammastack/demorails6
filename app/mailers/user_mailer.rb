class UserMailer < ApplicationMailer
  def reset_password_instructions(user)
    @user = user
    @greeting = "Hi"
    mail to: user.email, subject: 'Reset password instructions'
  end 

  def welcome_email(user)
    @user = user
    @url  = 'http://localhost:3000/'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
