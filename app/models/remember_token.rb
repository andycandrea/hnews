class RememberToken
  attr_reader :value
  
  def initialize(value = nil)
    @value = (value || create_value).to_s
  end
  
  def digest
    @digest ||= Digest::SHA1.hexdigest(value)
  end

  def to_s
    value
  end

  private

  def create_value
    SecureRandom.urlsafe_base64
  end
end
