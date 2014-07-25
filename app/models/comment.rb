class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  has_many :votes, as: :votable

  validates :body, :commentable, :user, presence: true
end
