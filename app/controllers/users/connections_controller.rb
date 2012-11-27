class Users::ConnectionsController < Users::ApplicationController

  def show
    connection = current_user.connections.find(params[:id])

    if connection.protocol == :vnc
      redirect_to "/clients/vnc/?uid=#{current_user.id}&sid=#{params[:id]}"
    else
      @ssh_relay_host = Rails.application.config.ssh_relay_host
    end
  end

  def credentials
    connection = current_user.connections.find(params[:id])
    render json: connection
  end

end
