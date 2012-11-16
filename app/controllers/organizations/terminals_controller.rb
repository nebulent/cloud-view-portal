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
      redirect_to terminals_path
    else
      flash.now[:error] = 'There was an error creating the terminal'
      render :new
    end
  end

  def update
    @terminal = @organization.terminals.find(params[:id])

    unless @terminal.update_attributes(params[:terminal])
      flash.now[:error] = 'There was a erro updating the terminal'
    end

    render :edit
  end

  def destroy
    @terminal = @organization.terminals.find(params[:id])
    @terminal.destroy
    redirect_to terminals_path
  end
end
