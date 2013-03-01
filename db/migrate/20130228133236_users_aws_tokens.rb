class UsersAwsTokens < ActiveRecord::Migration
  def up
    create_table :aws_tokens_users do |t|
      t.belongs_to :user
      t.belongs_to :aws_token
    end
  end

  def down
    drop_table :aws_tokens_users
  end
end
