class Users::ConnectionsController < Users::ApplicationController

  def show
    connection = Connection.find(params[:id])

    if connection.protocol == :vnc
      redirect_to "/clients/vnc/?uid=#{current_user.id}&sid=#{params[:id]}"
    else
      @ssh_relay_host = Rails.application.config.ssh_relay_host
      @credentials = connection.to_json
    end
  end

end
