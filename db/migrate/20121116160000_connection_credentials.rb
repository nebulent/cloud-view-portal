class ConnectionCredentials < ActiveRecord::Migration
  def up
    change_table :connections do |t|
      t.string :credentials
    end
  end

  def down
    change_table :connections do |t|
      t.remove :credentials
    end
  end
end
