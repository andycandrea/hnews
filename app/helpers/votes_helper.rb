module VotesHelper
  def vote_url(votable)
    "/#{votable.class.to_s.downcase}s/#{votable.id}/votes/1/"
  end

  def votable_score(votable)
    "#{Vote.where(votable_type: votable.class, votable_id: votable.id, is_up: true).count - 
      Vote.where(votable_type: votable.class, votable_id: votable.id, is_up: false).count}"
  end

  def votable_id_attr(votable)
    "#{votable.class.to_s.downcase}-#{votable.id}-votes"
  end

  def vote_arrow(direction, votable)
    vote = Vote.find_by(user: current_user, votable: votable)

    if vote.present? && vote.is_up && direction == 'up'
      content_tag(:div, '', class: 'up vote clicked')
    elsif vote.present? && !vote.is_up && direction == 'down'
      content_tag(:div, '', class: 'down vote clicked')
    else
      content_tag(:div, '', class: "#{direction} vote")
    end
  end
end
