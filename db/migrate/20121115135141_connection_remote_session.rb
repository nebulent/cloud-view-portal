class ConnectionRemoteSession < ActiveRecord::Migration
  def up
    change_table :remote_sessions do |t|
      t.remove :terminal_id
      t.belongs_to :connection
    end
  end

  def down
    change_table :remote_sessions do |t|
      t.remove :connection_id
      t.belongs_to :terminal
    end
  end
end
