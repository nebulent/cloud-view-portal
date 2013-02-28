class AwsToken < ActiveRecord::Base
  attr_accessible :active_at, :period, :user_id
  has_and_belongs_to_many :users

end
