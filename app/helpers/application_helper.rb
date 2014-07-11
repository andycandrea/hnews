module ApplicationHelper
  def format_date(date)
    "#{distance_of_time_in_words(date, Time.now, options = {})} ago"
  end
  
  def url_for_article(article)
    article.url.presence || article_path(article)
  end
end
