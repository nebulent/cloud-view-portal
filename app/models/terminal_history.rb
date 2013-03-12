class TerminalHistory < ActiveRecord::Base

  attr_accessible :connection, :user, :history

  belongs_to :connection
  belongs_to :user

end
