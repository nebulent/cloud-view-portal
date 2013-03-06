class Users::SessionsController < Devise::SessionsController
  def create
    if !request.subdomain.present?
      sign_in User.find_by_email(params[:user][:email])
      subdomain = User.find_by_email(request.params[:user][:email]).organization.subdomain
      return redirect_to root_url.gsub("http://", "http://#{subdomain}.")
    end
    super
  end
end
