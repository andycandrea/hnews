class UserMailer < ActionMailer::Base
  default from: 'haxx0rnews@gmail.com'

  def reset_password_email(user)
    @user = user
    mail to: @user.email, subject: 'Haxx0r News - Reset Password'
  end  
end
