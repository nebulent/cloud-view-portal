class AwsToken < ActiveRecord::Base
  attr_accessible :link, :period
  belongs_to :users

  validates_presence_of :link, :period

end
