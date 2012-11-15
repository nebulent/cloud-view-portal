class TerminalsController < ApplicationController
  def index
    @terminals = Terminal.all
  end

  def new
    @terminal = Terminal.new
  end

  def edit
    @terminal = Terminal.find(params[:id])
  end

  def create
    @terminal = Terminal.new(params[:terminal])

    if @terminal.save
      redirect_to terminals_path
    else
      flash.now[:error] = 'There was an error creating the terminal'
      render :new
    end
  end

  def update
    @terminal = Terminal.find(params[:id])

    unless @terminal.update_attributes(params[:terminal])
      flash.now[:error] = 'There was a erro updating the terminal'
    end

    render :edit
  end

  def destroy
    @terminal = Terminal.find(params[:id])
    @terminal.destroy
    redirect_to terminals_path
  end
end