class GuacamoleSession< ActiveRecord::Base
  set_table_name "configuration"
  attr_accessible :id, :config
end
