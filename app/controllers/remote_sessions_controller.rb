class RemoteSessionsController < ApplicationController

  def create
    @terminal = Terminal.find(params[:term_id])
    @session = @terminal.create_session

    render json: { id: @session.id, host: @session.host, port: @session.port }
  end

  def destroy
    session = RemoteSession.find(params[:id])

    render json: { success: session.destroy }
  end

end
