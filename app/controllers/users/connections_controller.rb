class Users::ConnectionsController < Users::ApplicationController

  def show
    redirect_to "/clients/vnc/?uid=#{current_user.id}&sid=#{params[:id]}"
  end

end
