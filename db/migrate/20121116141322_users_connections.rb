class UsersConnections < ActiveRecord::Migration
  def up
    create_table :users_connections, id: false do |t|
      t.integer :user_id
      t.integer :connection_id
    end
  end

  def down
    drop_table :users_connections
  end
end
