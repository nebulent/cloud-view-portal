class ChangeLinkType < ActiveRecord::Migration
  def up
    change_column :aws_tokens, :link, :text
  end

  def down
    change_column :aws_tokens, :link, :string
  end
end
