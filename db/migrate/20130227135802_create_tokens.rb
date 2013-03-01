class CreateTokens < ActiveRecord::Migration
  def up
    create_table :tokens do |t|
      t.datetime :active_at
      t.integer  :period

      t.timestamps
    end
  end

  def down
    drop_table :tokens
  end
end
