class AddAmazonCredentialsToOrganization < ActiveRecord::Migration
  def change
    change_table :organizations do |t|
      t.string :aws_key_id
      t.string :aws_secret_key
    end
  end
end
