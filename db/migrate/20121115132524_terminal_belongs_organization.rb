class TerminalBelongsOrganization < ActiveRecord::Migration
  def up
    change_table :terminals do |t|
      t.belongs_to :organization
    end
  end

  def down
     change_table :terminals do |t|
      t.remove :organization_id
    end
  end
end
