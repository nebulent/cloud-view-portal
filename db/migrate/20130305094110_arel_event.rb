class ArelEvent < ActiveRecord::Migration
  def up
    create_table :events do |t|
      t.timestamps
      t.string :level, :name, :entity, :message, :user_email
      t.integer :organization_id
    end
  end

  def down
    drop_table :events
  end
end
