class AddConnection < ActiveRecord::Migration
  def up
    create_table :connections do |t|
      t.belongs_to :terminal
      t.string :user
      t.integer :port
    end
  end

  def down
    drop_table :connections
  end
end
