class CommentsController < ApplicationController
  before_action :require_signin
  before_action :find_article

  def create
    @comment = current_user.comments.build(comment_params.merge(article: @article)) 

    if @comment.save
      redirect_to @article, flash: { success: 'Comment successfully added.' }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_id, :article_id)
  end

  def find_article
    @article ||= Article.find(params[:article_id])
  end
end
