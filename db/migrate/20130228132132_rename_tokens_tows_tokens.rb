class RenameTokensTowsTokens < ActiveRecord::Migration
  def up
    rename_table :tokens, :aws_tokens
  end

  def down
    rename_table :aws_tokens, :tokens
  end
end
