class AddUserIdToToken < ActiveRecord::Migration
  def change
    add_column :tokens, :user_id, :integer
    add_column :tokens, :organization_id, :integer
  end
end
