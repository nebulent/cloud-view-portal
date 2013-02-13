class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum :role, [:users, :admin, :account_admin]

  belongs_to :organization
  has_and_belongs_to_many :connections, join_table: :users_connections

  attr_accessible :email, :password, :password_confirmation,
                  :remember_me, :role

  def log_event (attrs)
    organization.log_event {:user_id => id}.merge(attrs)
  end
end
