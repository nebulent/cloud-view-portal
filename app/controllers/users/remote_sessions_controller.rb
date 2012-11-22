class Users::RemoteSessionsController < Users::ApplicationController
  skip_before_filter :authenticate_user!

  def create
    user = User.find(params[:uid])
    connection = user.connections.find(params[:sid])
    helper = ConnectionSessionHelper.new(connection)
    session  = helper.create_session

    render json: { id: session.id,
                   host: connection.host,
                   port: session.port,
                   pass: connection.credentials }
  end

  def destroy
    session = RemoteSession.find(params[:id])
    helper = ConnectionSessionHelper.new(session.connection, session)
    render json: { success: helper.destroy_session }
  end

end
