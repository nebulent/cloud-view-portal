class CreateGuacamoleSessions < ActiveRecord::Migration
  def change
    create_table :guacamole_sessions, :id => false do |t|
      t.string :token
      t.string :auth_json

      t.timestamps
    end
  end
end
