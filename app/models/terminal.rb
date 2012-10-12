class Terminal < ActiveRecord::Base

  attr_accessible :name, :uri

  has_many :remote_sessions

  validates_presence_of :name, :uri
  validates_uniqueness_of :name, :uri

  def create_session
    remote_sessions.create
  end

  def username
    URI(uri).user
  end

  def host
    URI(uri).host
  end

  def port
    URI(uri).port
  end

end
