class Organizations::TerminalsController < Organizations::ApplicationController
  def index
    @terminals = @organization.terminals.all
  end

  def new
    @terminal = @organization.terminals.new
  end

  def show
    @terminal = @organization.terminals.find(params[:id])
    @users = @terminal.connections.map(&:users).flatten.uniq
  end

  def edit
    @terminal = @organization.terminals.find(params[:id])
  end

  def create
    @terminal = @organization.terminals.new(params[:terminal])

    if @terminal.save
      event.info(:message => "Terminal with id #{@terminal.id} has been created")
      redirect_to organizations_dashboard_path('index')
    else
      render :new
    end
  end

  def update
    @terminal = @organization.terminals.find(params[:id])

    if @terminal.update_attributes(params[:terminal])
      event.info(:message => "Terminal with id #{@terminal.id} has been updated")
      flash[:success] = 'Terimnal successfully updated'
      redirect_to organizations_dashboard_path(:index)
    else
      render :edit
    end
  end

  def destroy
    @terminal = @organization.terminals.find(params[:id])
    @terminal.destroy
    event.info(:message => "Terminal with id #{@terminal.id} has been deleted")
    redirect_to organizations_dashboard_path(:index)
  end
end
