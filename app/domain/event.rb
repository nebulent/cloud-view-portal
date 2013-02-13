class Event
  include Mongoid::Document
  include Mongoid::Timestamps

  field :level, :type => String
  field :name, :type => String
  field :entity, :type => String
  field :message, :type => String
  field :organization_id, :type => Integer
  field :user_id, :type => Integer
end
