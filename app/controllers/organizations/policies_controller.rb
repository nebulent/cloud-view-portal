class Organizations::PoliciesController < Organizations::ApplicationController

  def index
    @users = @organization.users
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
    else
      flash[:error] = 'Invalid policy request'
    end

    redirect_to new_organizations_policy_path
  end

  def destroy
    connection = Connection.find(params[:id])
    user = User.find(params[:user_id])

    if connection and user
      user.connections.delete(connection)
      flash[:success] = 'The rule has been successfully removed'
    else
      flash[:error] = 'failed to remove the rule'
    end

    redirect_to organizations_policies_path
  end

end
