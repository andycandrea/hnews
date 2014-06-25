class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to root_path
    else
      render :new
    end
  end

  def index
    @articles = Article.order(created_at: :desc)
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :url)
  end
end
