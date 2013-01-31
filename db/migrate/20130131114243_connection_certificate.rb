class ConnectionCertificate < ActiveRecord::Migration
  def up
    add_attachment :connections, :certificate
  end

  def down
    remove_attachment :connections, :certificate
  end
end
