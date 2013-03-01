class Organization < ActiveRecord::Base
  belongs_to :head
  has_many :users
  has_many :terminals

  attr_accessible :name, :aws_key_id, :aws_secret_key, :subdomain

  validates_presence_of :name, :subdomain
  validates_uniqueness_of :name, :subdomain
  validates_format_of :subdomain, :with => /^[\S][-_A-Z0-9a-z]+$/, :message => "must have only letters, - , _ and numbers"

  accepts_nested_attributes_for :head, :allow_destroy => true

  def log (attrs={})
    params = {:organization_id => id}.merge(attrs)
    OrganizationEventLog.new(params)
  end

  def events
    Event.where(:organization_id => id)
  end
  
  def has_amazon_credentials?
    aws_secret_key.present? and  aws_key_id.present?
  end
end
