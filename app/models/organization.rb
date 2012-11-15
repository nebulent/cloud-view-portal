class Organization < ActiveRecord::Base

  belongs_to :head
  has_many :users
  has_many :terminals

end
