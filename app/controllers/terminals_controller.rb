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
      render :new
    end
  end

  def update
    @terminal = Terminal.find(params[:id])

    if @terminal.update_attributes(params[:terminal])
    end

    render :edit
  end

  def destroy
    @terminal = Terminal.find(params[:id])
    @terminal.destroy
    redirect_to terminals_path
  end
end
