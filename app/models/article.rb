class Article < ActiveRecord::Base
  validates :title, presence: true
  validates :url, full_url: true

  validate :single_article_type
  
  before_save :sanitize_url

  private

  def single_article_type
    if (url.blank? and content.blank?)
      errors.add(:base, "URL or content must have a value.")
      return false
    elsif (!url.blank? and !content.blank?)
      errors.add(:base, "Article cannot contain both a URL and text content.")
      return false
    else
      return true
    end
  end

  def sanitize_url
    unless self.url == "" or self.url.start_with?("http")
      self.url = "http://" + self.url
    end
  end

end
