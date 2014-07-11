module ApplicationHelper
  def url_for_article(article)
    article.url? ? article.url : article_path(article)
  end
end
