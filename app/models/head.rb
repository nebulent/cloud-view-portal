class Head < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :organizations, :dependent => :destroy, :autosave => true
  accepts_nested_attributes_for :organizations

  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :organizations_attributes

  def after_database_authentication
    Event.create :message => "Head with id #{id} has logged in",
                 :entity => "OrganizationSession",
                 :name => "login",
                 :level => 'info'
  end
end
