class ArticlesController < ApplicationController
  before_action :require_signin, only: [:new, :create]

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to root_path, flash: { success: 'Article successfully created.' }
    else
      render :new
    end
  end

  def index
    @articles = Article.limit(Article::ARTICLES_PER_PAGE).offset(find_offset).order(created_at: :desc)
  end

  def show
    @article = Article.find(params[:id])
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :url)
  end

  def find_offset
    (find_page_num - 1) * Article::ARTICLES_PER_PAGE
  end

  def find_page_num
    @page_num ||= [1, params[:page_number].to_i].max
  end

  def total_page_num
    @total_page_num = Article.count / Article::ARTICLES_PER_PAGE + 1
  end

  helper_method :total_page_num
end
