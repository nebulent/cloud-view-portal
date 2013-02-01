class Organizations::TerminalsController < Organizations::ApplicationController
  def index
    @terminals = @organization.terminals.all
  end

  def new
    @terminal = @organization.terminals.new
  end

  def edit
    @terminal = @organization.terminals.find(params[:id])
  end

  def create
    @terminal = @organization.terminals.new(params[:terminal])

    if @terminal.save
      redirect_to organizations_dashboard_path('index')
    else
      render :new
    end
  end

  def update
    @terminal = @organization.terminals.find(params[:id])

    unless @terminal.update_attributes(params[:terminal])
      render :edit
    else
      flash[:success] = 'Terimnal successfully updated'
      redirect_to organizations_dashboard_path(:index)
    end
  end

  def destroy
    @terminal = @organization.terminals.find(params[:id])
    @terminal.destroy
    redirect_to organizations_terminals_path
  end
end
