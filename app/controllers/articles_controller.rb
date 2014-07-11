class ArticlesController < ApplicationController
  PER_PAGE = 20
  
  before_action :require_signin, only: [:new, :create]

  def new
    @article = Article.new
  end

  def create
    if article.save
      redirect_to root_path, flash: { success: 'Article successfully created.' }
    else
      render :new
    end
  end

  def index
    @articles = Article.limit(PER_PAGE).offset(current_offset).order(created_at: :desc)
  end

  def show
    @article = Article.find(params[:id])
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :url)
  end

  def article
    @article = current_user.articles.build(article_params)
  end

  def comment
    @comment = Comment.new
  end
  helper_method :comment

  def current_offset
    (current_page - 1) * PER_PAGE
  end

  def current_page
    @page_num ||= [1, params[:page_number].to_i].max
  end
  helper_method :current_page

  def total_pages
    @total_pages ||= Article.count / PER_PAGE + 1
  end
  helper_method :total_pages
end
