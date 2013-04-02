class RenameConfigurationColumns < ActiveRecord::Migration
  def up
    rename_column :configuration, :token, :id
    rename_column :configuration, :auth_json, :config
  end

  def down
    rename_column :configuration, :id, :token
    rename_column :configuration, :config, :auth_json
  end
end
