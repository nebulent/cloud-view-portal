class Head < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  accepts_nested_attributes_for :organization

  has_one :organization

  attr_accessible :email, :password, :password_confirmation, :remember_me
end
