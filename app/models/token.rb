class Token < ActiveRecord::Base
  attr_accessible :active_at, :period, :user_id
  belongs_to :user

end
