class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :users, :remember_token, :remember_token_digest
  end
end
