class Article < ActiveRecord::Base
  ARTICLES_PER_PAGE = 20

  before_validation :prepend_url_scheme, if: :url?

  validates :title, presence: true
  validates :url, full_url: true, if: :url?
  validate :single_article_type

  private

  def single_article_type
    if (has_only_title?)
      errors.add(:base, "URL or content must have a value.")
    elsif (has_multiple_article_types?)
      errors.add(:base, "Article cannot contain both a URL and text content.")
    end
  end

  def has_only_title?
    url.blank? && content.blank?
  end

  def has_multiple_article_types?
    url? && content?
   end

  def prepend_url_scheme
    unless url.start_with?("http")
      self.url = "http://#{url}"
    end
  end
end
