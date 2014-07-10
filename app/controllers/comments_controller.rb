class CommentsController < ApplicationController
  skip_before_action :store_redirect_url
  before_action :require_signin

  def create
    @commentable = find_commentable
    @comment = current_user.comments.build(comment_params.merge(commentable: @commentable)) 

    if @comment.save
      flash[:success] = 'Comment successfully added.'
    else
      flash[:danger] = 'Comment cannot be blank.'
    end

    redirect_to redirect_url
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def valid_commentable_type(type)
    type.in? %w[comment article]
  end

  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/ && valid_commentable_type($1)
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end
