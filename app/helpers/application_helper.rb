module ApplicationHelper
  def url_for_article(article)
    article.url.presence || article_path(article)
  end
end
