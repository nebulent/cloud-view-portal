class GuacamoleAuthController < ApplicationController

  def check
    user = User.where(email: params[:username],
                      encrypted_password: params[:password]).first

    if user
      return render json: GuacamoleAuthProvider.user_connections(user)
    else
      return render nothing: true, status: 401
    end
  end

end
