class Organizations::ConnectionsController < Organizations::ApplicationController
  before_filter :fetch_terminal

  def index
    @connections = @terminal.connections
  end

  private

  def fetch_terminal
    @terminal = Terminal.find(params[:terminal_id])
  end
end
