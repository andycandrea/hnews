module ApplicationHelper
  def format_date(date)
    "#{time_ago_in_words(date, include_seconds: true)} ago"
  end
  
  def url_for_article(article)
    article.url.presence || article_path(article)
  end
end
