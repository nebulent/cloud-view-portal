class AddOrganization < ActiveRecord::Migration
  def up
    create_table :organizations do |t|
      t.belongs_to :head
      t.string :name
    end
  end

  def down
    drop_table :organizations
  end
end
