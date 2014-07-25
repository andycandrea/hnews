class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates :user, :votable, presence: true
  validates :user, uniqueness: { scope: [:votable_id, :votable_type] }
end
