class TerminalHistory < ActiveRecord::Migration
  def up
    create_table :terminal_histories do |t|
      t.belongs_to :connection
      t.belongs_to :user
      t.text :history
    end
  end

  def down
    drop_table :terminal_histories
  end
end
