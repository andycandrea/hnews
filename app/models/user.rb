class User < ActiveRecord::Base
  before_save { self.email = email.downcase if email? }
  before_create :create_remember_token

  #Temporary regex - will eventually validate by sending an email
  EMAIL_REGEX = /\A[\x00-\x1F!\#\$%&\'\*\+-\/0-9=\?A-Z\x5E-\x7F]+@(([a-zA-Z][a-zA-Z0-9]+)|(([a-zA-Z]([a-zA-Z0-9])+\.)+([a-zA-Z]([a-zA-Z0-9])+)))\Z/

  validates :name, :email, presence: true, uniqueness: { case_sensitive: false }
  validates :name, length: { maximum: 20 }
  validates :email, format: { with: EMAIL_REGEX }
  validates :password, length: { minimum: 6 }
  has_secure_password


  def generate_remember_token
    self.class.new_remember_token.tap do |token|
      update_column(:remember_token, self.class.digest(token))
    end
  end

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token) 
  end

end
