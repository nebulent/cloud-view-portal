class Head < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :organizations
  accepts_nested_attributes_for :organizations

  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :organization_attributes

  def after_database_authentication
    Event.create :message => "Head with id #{id} has logged in",
                 :entity => "OrganizationSession",
                 :name => "login",
                 :level => 'info'
  end
end
