class Organizations::@organizations.users.Controller < Organizations::ApplicationController
  def index
    @users = @organization.users.all
  end

  def new
    @user = @organization.users.new
  end

  def edit
    @user = @organization.users.find(params[:id])
  end

  def create
    @user = @organization.users.new(params[:user])

    if @user.save
      redirect_to users_path
    else
      flash.now[:error] = 'There was an error creating the user'
      render :new
    end
  end

  def update
    @user = @organization.users.find(params[:id])

    unless @user.update_attributes(params[:user])
      flash.now[:error] = 'There was a erro updating the user'
    end

    render :edit
  end

  def destroy
    @user = @organizations.users.find(params[:id])
    @user.destroy
    redirect_to users_path
  end
end
