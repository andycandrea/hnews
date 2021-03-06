class Session
  include ActiveModel::Model

  attr_accessor :name, :password
  
  validate :user_account_exists

  def user
    @user ||= User.find_by name: name
  end

  private
  
  def user_account_exists
    unless user && user.authenticate(password)
      errors.add(:base, 'Invalid username or password')
    end
  end
end
