class GuacamoleAuthController < ApplicationController

  def check
    user = User.find_by_email(params[:username])

    if user and user.valid_password?(params[:password])
      return render json: GuacamoleAuthProvider.user_connections(user)
    else
      return render nothing: true, status: 401
    end
  end

end
