class Head < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :organization
  accepts_nested_attributes_for :organization

  validates_presence_of :organization

  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :organization_attributes

  def after_database_authentication
    organization.log.info(:message => "Organization head with id #{id} has logged in",
                          :entity => "OrganizationSession",
                          :name => "login")
  end
end
