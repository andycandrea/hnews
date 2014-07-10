class AddPolymorphismToComment < ActiveRecord::Migration
  def change
    remove_belongs_to :comments, :article

    add_reference :comments, :commentable, polymorphic: true, null: false
  end
end
