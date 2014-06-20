class FullUrlValidator < ActiveModel::EachValidator

  VALID_SCHEMES = %w(http https)
  
  def validate_each(record, attribute, value)
   
    unless (valid_full_url?(value) ||  value == "")
      record.errors[attribute] << (options[:message] || 'is not a valid URL.')
    end
  end
  
  private
  
  def valid_full_url?(url)  
    url = URI.parse(url)    
    url.scheme.in?(VALID_SCHEMES) && url.host

  rescue URI::InvalidURIError
    false
  end

end
