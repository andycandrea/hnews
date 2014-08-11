class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  has_many :votes, as: :votable

  validates :body, :commentable, :user, presence: true

  def num_replies 
    if comments.any?
      comments.inject(comments.count) { |sum, reply| sum + reply.num_replies }
    else
      0
    end
  end
end
