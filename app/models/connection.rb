class Connection < ActiveRecord::Base
  enum :protocol, [:vnc]

  belongs_to :terminal
  has_many :remote_sessions
  has_and_belongs_to_many :users

  attr_accessible :user, :protocol, :port

end
