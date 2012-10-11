class AddRemoteSessions < ActiveRecord::Migration
  def up
    create_table :remote_sessions do |t|
      t.belongs_to :terminal
      t.integer :pid, :null => false
    end
  end

  def down
    drop_table :remote_sessions
  end
end
