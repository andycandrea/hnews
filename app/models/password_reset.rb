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

    return false if user.nil? || expired?

    if user.update_attributes(password: password, password_confirmation: password_confirmation)
      user.destroy_password_reset_token
    else
      errors.add(:base, 'Passwords must match and be at least six characters long.')
      return false
    end
  end
  
  private

  def token
    @token ||= Token.new
  end

  def expired?
    if user.password_reset_sent_at < 2.hours.ago
      errors.add(:base, 'Password reset has expired.')
    end
  end
end
