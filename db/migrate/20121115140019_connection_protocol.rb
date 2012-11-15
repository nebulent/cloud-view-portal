class ConnectionProtocol < ActiveRecord::Migration
  def up
    change_table :connections do |t|
      t.string :protocol
    end
  end

  def down
    change_table :connections do |t|
      t.remove :protocol
    end
  end
end
