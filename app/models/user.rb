class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum :role, [:users, :admin, :account_admin]

  belongs_to :organization
  has_and_belongs_to_many :connections, join_table: :users_connections

  attr_accessible :email, :password, :password_confirmation,
                  :remember_me, :role

  def log (attrs={})
    organization.log({:user_email => email }.merge(attrs))
  end

  def after_database_authentication
    log.info :message => "User has logged in",
             :entity => "UsersSession",
             :name => "login"
  end
end
