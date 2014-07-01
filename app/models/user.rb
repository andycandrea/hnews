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


  def send_password_reset
    generate_token(:password_reset_token)
    update_column(:password_reset_sent_at, Time.zone.now)
    #save!
    UserMailer.reset_password_email(self).deliver
  end

  def generate_token(column)
    new_token.tap do |token|
      update_column(column, Session.digest(token))
    end
  end

  def destroy_remember_token
    self.update_attribute(:remember_token, nil)
  end

  def new_token
    SecureRandom.urlsafe_base64
  end

  private

  def create_remember_token
    self.remember_token = Session.digest(new_token) 
  end

end
