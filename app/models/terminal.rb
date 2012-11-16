class Terminal < ActiveRecord::Base

  attr_accessible :name, :uri

  belongs_to :organization

  has_many :connections

  validates_presence_of :name, :uri
  validates_uniqueness_of :name, :uri

  def has_connections?
    connections.any?
  end

  def host
    URI(uri).host
  end

end
