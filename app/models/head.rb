class Head < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :organization

  attr_accessible :email, :password, :password_confirmation, :remember_me
end
