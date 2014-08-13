class VotesController < ApplicationController
  skip_before_action :store_redirect_url
  before_action :require_signin
  before_action :vote, only: [:upvote, :downvote]

  def upvote
    if vote.is_up == true
      destroy
    else
      vote.is_up = true
      create
    end
  end

  def downvote
    if vote.is_up == false
      destroy
    else
      vote.is_up = false
      create
    end
  end

  def create
    respond_to do |format|
      if vote.save
        format.js { render template: 'votes/vote' }
      else
        format.html { redirect_to :back }
        flash.now[:danger] = 'Invalid vote'
      end
    end
  end

  def destroy
    respond_to do |format|
      if vote.destroy
        format.js { render template: 'votes/vote' }
      else
        format.html { redirect_to :back }
        flash.now[:danger] = 'Vote cannot be destroyed'
      end
    end
  end

  private

  def valid_votable_type?(type)
    type.in? %w[comment article]
  end

  def vote
    @vote ||= current_user.votes.where(votable: votable).first_or_initialize
  end

  def votable
    @votable = begin
      params.each do |name, value|
        if name =~ /(.+)_id$/ && valid_votable_type?($1)
          return $1.classify.constantize.find(value)
        end
      end

      nil
    end
  end
  helper_method :votable
end
