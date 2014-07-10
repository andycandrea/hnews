class AddUserRelationshipToArticles < ActiveRecord::Migration
  def change
    add_belongs_to :articles, :user
  end
end
