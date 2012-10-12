class AddHostPortRemoteSessions < ActiveRecord::Migration
  def up
    add_column :remote_sessions, :host, :string
    add_column :remote_sessions, :port, :integer
  end

  def down
    remove_column :remote_sessions, :host
    remove_column :remote_sessions, :port
  end
end
