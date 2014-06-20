class Article < ActiveRecord::Base
  before_validation :sanitize_url, if: :url?

  validates :title, presence: true

  validates :url, full_url: true
  validate :single_article_type
  validate :no_nil_params

  private

  def single_article_type
    if (has_only_title?)
      errors.add(:base, "URL or content must have a value.")
    elsif (has_two_article_types?)
      errors.add(:base, "Article cannot contain both a URL and text content.")
    end
  end

  def has_only_title?
    url.blank? && content.blank?
  end

  def has_two_article_types?
    !url.blank? && !content.blank?
  end

  def sanitize_url
    unless url == "" || url.start_with?("http")
      self.url = "http://" + url
    end
  end

  def no_nil_params
    if (content.nil? || url.nil?) 
      errors.add(:base, "Nil values not accepted.")
    end
  end
end
