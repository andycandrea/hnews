class Session
  include ActiveModel::Model

  attr_accessor :name, :password
  
  validate :user_account_exists

  def user
    @user ||= User.find_by name: name
  end

  def self.load_user(token)
    User.find_by_remember_token(Session.digest(token))
  end

  def self.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
  
  def user_account_exists
    unless user && user.authenticate(password)
      errors.add(:base, 'Invalid username or password')
    end
  end
end
