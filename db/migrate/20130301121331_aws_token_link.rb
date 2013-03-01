class AwsTokenLink < ActiveRecord::Migration
  def up
    remove_column :aws_tokens, :active_at
    add_column :aws_tokens, :link, :string
  end

  def down
    remove_column :aws_tokens, :link
    add_column :aws_tokens, :active_at, :string
  end
end
