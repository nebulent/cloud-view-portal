class Connection < ActiveRecord::Base
  enum :protocol, [:vnc]

  belongs_to :terminal
  has_many :remote_sessions
  has_and_belongs_to_many :users, join_table: :users_connections

  attr_accessible :user, :protocol, :port, :credentials

  def to_s
    "protocol: #{protocol} user: #{user} port:#{port}"
  end

end
