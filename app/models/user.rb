class User < ActiveRecord::Base
  enum :role [:users, :admin, :account_admin]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :role

  belongs_to :organization
  has_and_belongs_to_many :connections, join_table: :users_connections

  attr_accessible :email, :password, :password_confirmation, :remember_me
end
