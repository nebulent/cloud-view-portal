class Connection < ActiveRecord::Base
  enum :protocol, [:vnc, :ssh, :rdp]

  belongs_to :terminal
  has_many :remote_sessions
  has_many :terminal_histories
  has_and_belongs_to_many :users, join_table: :users_connections

  attr_accessible :user, :protocol, :port, :credentials, :certificate
  has_attached_file :certificate, :path => ":rails_root/storage/keys/:id/:basename.:extension"

  validates_presence_of :port

  def has_certificate?
    certificate.exists?
  end

  def as_json(options={})
    super(options.merge(methods: [:host]))
  end

  def to_s
    "protocol: #{protocol} user: #{user} port:#{port}"
  end

  def host
    terminal.uri
  end

  def create_session (params={})
    remote_sessions.create({
      port: port
    }.merge(params))
  end

end
