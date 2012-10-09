class Terminal < ActiveRecord::Base

  attr_accessible :name, :uri

  validates_presence_of :name, :uri

end
