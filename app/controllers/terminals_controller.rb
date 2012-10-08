class TerminalsController < ApplicationController
  def index
    @terminals = Terminal.all
  end

  def new
    @terminal = Terminal.new
  end

  def create
    @terminal = Terminal.new(params[:terminal])

    if @terminal.save
      redirect_to terminals_path
    end
  end

  def destroy
    @terminal = Terminal.find(params[:id])
    @terminal.destroy
    redirect_to terminals_path
  end
end
