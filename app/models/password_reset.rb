class PasswordReset
  include ActiveModel::Model

  attr_accessor :email, :token, :password, :password_confirmation

  def user
    @user ||= if email.present?
                User.find_by!(email: email)
              else
                User.find_by!(password_reset_token: token)
              end
  end
  
  def deliver
    user.save_password_reset_token(token)
    UserMailer.reset_password_email(user).deliver
  rescue ActiveRecord::RecordNotFound
    errors.add(:base, 'No user exists with that email.')
  end

  def update_user
    user.reload
   
    if user.nil?
      errors.add(:base, 'No user specified.')
    elsif expired?
      errors.add(:base, 'Password reset has expired.')
    elsif invalid_password?
      errors.add(:base, 'Password fields must match and be at least six characters.')
    else 
      user.destroy_password_reset_token
      user.update_attributes(password: password, password_confirmation: password_confirmation)
    end

    return errors.none?
  end
  
  private

  def token
    @token ||= Token.new
  end

  def expired?
    user.password_reset_sent_at < 2.hours.ago
  end

  def invalid_password?
    !(password == password_confirmation && password.length >= 6)
  end
end
