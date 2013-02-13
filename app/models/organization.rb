class Organization < ActiveRecord::Base

  belongs_to :head
  has_many :users
  has_many :terminals

  attr_accessible :name

  validates_presence_of :name

  def log
    @log ||= OrganizationEventLog.new(id)
  end

  def events
    Event.where(:organization_id => id)
  end
end
