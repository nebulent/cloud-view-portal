class RenameGuacamoleSessionToConfiguration < ActiveRecord::Migration
  def up
    rename_table :guacamole_sessions, :configuration
  end

  def down
    rename_table :configuration, :guacamole_session
  end
end
