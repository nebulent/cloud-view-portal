module Users::ConnectionsHelper
  def connect_link (name, conn, options={})
    defaults = {
      :target => '_blank', :class => 'connectLink'
    }.merge(options)
    link_to name, users_connection_path(conn), defaults
  end
end
