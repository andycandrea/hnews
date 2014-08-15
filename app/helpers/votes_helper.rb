module VotesHelper
  def votable_score(votable)
    votes = votable.votes

    (votes.where(is_up: true).count - votes.where(is_up: false).count).to_s
  end

  def votable_id_attr(votable)
    "#{votable.class.to_s.downcase}-#{votable.id}-votes"
  end

  def vote_arrow(direction, votable)
    vote = Vote.find_by(user: current_user, votable: votable)

    classes = %W[#{direction} vote].tap do |classes|
      if vote && ((vote.up? && direction == 'up') || (vote.down? && direction == 'down'))
        classes << 'clicked'
      end
    end

    content_tag :div, '', class: classes.join(' ')
  end
end
