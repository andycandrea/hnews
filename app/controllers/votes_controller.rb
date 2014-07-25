class VotesController < ApplicationController
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
    if vote.save
      redirect_to redirect_url
    else
      flash.now[:danger] = 'Invalid vote'
    end
  end

  def destroy
    vote.destroy
    redirect_to redirect_url
  end

  private

  def valid_votable_type?(type)
    type.in? %w[comment article]
  end

  def vote
    @vote ||= current_user.votes.where(votable_type: votable.class, votable_id: votable.id).first || current_user.votes.build(votable: votable)
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
end
