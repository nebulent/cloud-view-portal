class Organizations::PoliciesController < Organizations::ApplicationController

  def all
    #
  end

  def new
    @users = @organization.users
    @terminals = @organization.terminals
  end

  def create
    terminal = @organization.terminals.find(params[:terminal])
    connection = terminal.connections.find(params[:connection])
    user = @organization.users.find(params[:user])

    if terminal and connection and user
      user.connections << connection
      flash[:success] = 'The policy was successfully created'
      redirect_to new_organizations_policy_path
    else
      flash[:error] = 'Invalid policy request'
      redirect_to new_organizations_policy_path
    end
  end

  def destroy
    #
  end

end
