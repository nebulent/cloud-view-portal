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
      event.info(:message => "User #{user.email} is authorized to connect
                              to terminal #{terminal.id}
                              via connection #{connection.id}")
      flash[:success] = 'The policy was successfully created'
    else
      flash[:error] = 'Invalid policy request'
    end

    redirect_to new_organizations_policy_path
  end

  def destroy
    connection = Connection.find(params[:id])
    terminal = connection.terminal
    user = User.find(params[:user_id])

    if connection and user
      user.connections.delete(connection)
      event.info(:message => "User #{user.email} is no longer able to connect
                              to terminal #{terminal.id}
                              via connection #{connection.id}")
      flash[:success] = 'The rule has been successfully removed'
    else
      flash[:error] = 'failed to remove the rule'
    end

    redirect_to organizations_policies_path
  end

end
