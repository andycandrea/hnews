class AddNullFalseToColumns < ActiveRecord::Migration
  def change
    change_column_null :articles, :title, false
    change_column_null :articles, :user_id, false
    change_column_null :comments, :user_id, false
  end
end
