class TerminalHistory < ActiveRecord::Base

  attr_accessible :connection_id, :user_id, :history

  belongs_to :connection
  belongs_to :user

end
