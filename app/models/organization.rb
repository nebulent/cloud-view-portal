class Organization < ActiveRecord::Base
  belongs_to :head
  has_many :users
  has_many :terminals

  attr_accessible :name

  validates_presence_of :name
  validates_uniqueness_of :name

  def log (attrs={})
    params = {:organization_id => id}.merge(attrs)
    OrganizationEventLog.new(params)
  end

  def events
    Event.where(:organization_id => id)
  end
end
