class Organizations::ConnectionsController < Organizations::ApplicationController
  before_filter :fetch_terminal
  before_filter :get_protocols

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
      event.info(:message => "Connection with id #{@connection.id} has been created")
      flash.now[:success] = 'The connection has been successfully created'
      redirect_to organizations_terminal_path(@terminal)
    else
      render 'new'
    end
  end

  def edit
    @connection = @terminal.connections.find(params[:id])
  end

  def update
    @connection = @terminal.connections.find(params[:id])

    if @connection.update_attributes(params[:connection])
      event.info(:message => "Connection with id #{@connection.id} has been updated")
      flash.now[:success] = 'The connection has been saved'
    end

    render 'edit'
  end

  def destroy
    @connection = @terminal.connections.find(params[:id])

    if @connection.destroy
      event.info(:message => "Connection with id #{@connection.id} has been deleted")
      flash[:success] = 'The connection was destroyed'
    else
      flash[:error] = 'There was a error destroying the connection'
    end

    redirect_to :back
  end

  private

  def get_protocols
    @protocols = Connection::PROTOCOLS
  end

  def fetch_terminal
    @terminal = Terminal.find(params[:terminal_id])
  end
end
