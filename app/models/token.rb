class Token
  attr_reader :value

  def initialize(val = nil)
    @value = (val || create_token).to_s
  end

  def digest
    @digest ||= Digest::SHA1.hexdigest(value)
  end

  def to_s
    value
  end
  
  private

  def create_token
    SecureRandom.urlsafe_base64
  end
end
