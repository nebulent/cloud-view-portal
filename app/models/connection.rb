class Connection < ActiveRecord::Base
  enum :protocol, [:vnc]

  belongs_to :terminal
  has_many :remote_sessions

end
