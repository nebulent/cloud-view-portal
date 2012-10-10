class Terminal < ActiveRecord::Base

  attr_accessible :name, :uri

  validates_presence_of :name, :uri
  validates_uniqueness_of :name, :uri

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
