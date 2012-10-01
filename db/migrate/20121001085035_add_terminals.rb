class AddTerminals < ActiveRecord::Migration
  def up
    create_table :terminals do |t|
      t.string :name, :null => false
      t.string :uri , :null => false
    end
  end

  def down
    drop_table :terminals
  end
end
