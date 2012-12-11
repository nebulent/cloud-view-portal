class GuacamoleAuthController < ApplicationController

  def check
    begin
      render json: GuacamoleAuthProvider.user_connections(params[:username],
                                                          params[:password])
    rescue GuacamoleAuthProvider::InvalidCredentialsError
      render nothing: true, status: 401
    end
  end

end
