module VotesHelper
  def vote_url(votable)
    "/#{votable.class.to_s.downcase}s/#{votable.id}/votes/1/"
  end

  def votable_score(votable)
    "The score is: 
      #{Vote.where(votable_type: votable.class, votable_id: votable.id, is_up: true).count - 
        Vote.where(votable_type: votable.class, votable_id: votable.id, is_up: false).count}"
  end

  def votable_id_attr(votable)
    "#{votable.class.to_s.downcase}-#{votable.id}-votes"
  end
end
