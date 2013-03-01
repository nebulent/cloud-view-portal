class Organization < ActiveRecord::Base
  belongs_to :head
  has_many :users
  has_many :terminals

  attr_accessible :name, :subdomain

  validates_presence_of :name, :subdomain
  validates_uniqueness_of :name, :subdomain
  validates_format_of :subdomain, :with => /^[\S][-_A-Z0-9a-z]+$/, :message => "must have only letters, - , _ and numbers"

  def log (attrs={})
    params = {:organization_id => id}.merge(attrs)
    OrganizationEventLog.new(params)
  end

  def events
    Event.where(:organization_id => id)
  end
end
