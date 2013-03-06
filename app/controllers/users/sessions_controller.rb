class Users::SessionsController < Devise::SessionsController

  def after_sign_in_path_for (resource)
    users_dashboard_path('index')
  end

  def create
    puts "SUBDOMAIN #{request.subdomain}"
    if !request.subdomain.present?
      puts "SUBDOMAIN NOT PRESENT"
      subdomain = User.find_by_email(request.params[:user][:email]).organization.subdomain
      return redirect_to root_url.gsub("http://", "http://#{subdomain}.")
    end
    super
  end

  def new
    puts "CURRENT USEEEEEEEEEEER #{current_user}"
    super
  end
end
