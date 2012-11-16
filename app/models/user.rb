class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :organization
  has_and_belongs_to_many :connections

  attr_accessible :email, :password, :password_confirmation, :remember_me
end
