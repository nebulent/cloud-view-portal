class Event < ActiveRecord::Base
  attr_accessible :level, :name, :entity, :message, :organization_id,
                  :user_email
end
