class Organization < ActiveRecord::Base

  belongs_to :head
  has_many :users
  has_many :terminals

  attr_accessible :name

  validates_presence_of :name

  def log_event
    @log ||= OrganizationEventLog.new(id)
  end

end
