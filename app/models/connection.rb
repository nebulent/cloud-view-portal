class Connection < ActiveRecord::Base
  enum :protocol, [:vnc, :ssh]

  belongs_to :terminal
  has_many :remote_sessions
  has_and_belongs_to_many :users, join_table: :users_connections

  attr_accessible :user, :protocol, :port, :credentials

  validates_presence_of :credentials, :port

  def to_s
    "protocol: #{protocol} user: #{user} port:#{port}"
  end

  def host
    terminal.uri
  end

  def create_session (params)
    remote_sessions.create({
      port: port
    }.merge(params))
  end

end
