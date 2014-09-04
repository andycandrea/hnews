class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates :user, :votable, presence: true
  validates :user, uniqueness: { scope: [:votable_id, :votable_type] }

  def up?
    is_up?
  end

  def down?
    is_up == false 
  end
end
