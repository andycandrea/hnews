class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.boolean :is_up

      t.belongs_to :user, null: false
      t.references :votable, polymorphic: true, null: false
      
      t.timestamps
    end
  end
end
