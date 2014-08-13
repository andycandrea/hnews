module Votable
  extend ActiveSupport::Concern

  included { helper_method :votable }

  def vote
    @vote ||= current_user.votes.where(votable: votable).first_or_initialize
  end

  def votable
    @votable = begin
      if params[:controller] == 'articles'
        return Article.find(params[:id])
      elsif params[:controller] == 'comments'
        return Comment.find(params[:id])
      end

      nil
    end
  end

  def update_vote(direction)
    if vote.send("#{direction}?")
      response_for(:destroy)
    else
      vote.is_up = direction == :up
      response_for(:save)
    end
  end

  def response_for(action)
    respond_to do |format|
      format.js do
        if vote.send(action)
          render template: 'votes/vote'
        else
          render status: :unprocessable_entity
        end
      end
    end
  end
end
