class Users::RemoteSessionsController < Users::ApplicationController
  skip_before_filter :authenticate_user!

  def create
    user = User.find(params[:uid])
    connection = user.connections.find(params[:sid])
    session  = connection.create_session

    render json: { id: session.id,
                   host: connection.host,
                   port: session.port,
                   pass: connection.credentials }
  end

  def destroy
    session = RemoteSession.find(params[:id])
    render json: { success: session.destroy }
  end

end
