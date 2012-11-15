class Connection < ActiveRecord::Base

  belongs_to :terminal
  has_many :remote_sessions

end
