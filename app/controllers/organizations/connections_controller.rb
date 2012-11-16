class Organizations::ConnectionsController < Organizations::ApplicationController
  before_filter :fetch_terminal
  before_filter :get_protocols, :only => [:edit, :new]

  def index
    @connections = @terminal.connections

    respond_to do |fmt|
      fmt.html
      fmt.json { render json: @connections.to_json }
    end
  end

  def new
    @connection = @terminal.connections.new
  end

  def create
    @connection  = @terminal.connections.new(params[:connection])

    if @connection.save
      flash.now[:success] = 'The connection has been successfully created'
      redirect_to organizations_terminal_connections_path(@terminal.id)
    else
      render 'edit'
    end
  end

  def edit
    #
  end

  def update
    #
  end

  def destroy
    #
  end

  private

  def get_protocols
    @protocols = Connection::PROTOCOLS
  end

  def fetch_terminal
    @terminal = Terminal.find(params[:terminal_id])
  end
end
