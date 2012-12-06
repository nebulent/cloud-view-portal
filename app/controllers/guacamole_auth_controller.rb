class GuacamoleAuthController <  ApplicationController
  content_type :json

  def check
    user = User.where(username: params[:username],
                      encrypted_password: params[:password])

    if user
      render GuacamoleAuthHelper.user_connections(user).to_json
    else
      render nothing: true, status: 401
    end
  end
end
