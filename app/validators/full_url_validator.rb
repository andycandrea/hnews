class FullUrlValidator < ActiveModel::EachValidator

  VALID_SCHEMES = %w(http https)
  
  def validate_each(record, attribute, value)
    #Not a wonderful regex, but allows for URLs that don't include scheme
    url_regex = /^[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,}(:[0-9]{1,5})?(\/.*)?$/
    
    unless (valid_full_url?(value) || url_regex =~ value || value == "")
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
