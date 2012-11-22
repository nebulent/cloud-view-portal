class RemoteSession < ActiveRecord::Base

  attr_accessible :pid, :connection_id, :host, :port

  belongs_to :connection
  validates_presence_of :connection

end
