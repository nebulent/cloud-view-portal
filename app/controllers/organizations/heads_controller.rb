class Organizations::HeadsController < Organizations::ApplicationController
  def show
  end

  def new_organization
    @organization = current_head.organizations.new
  end

  def create_organization
    @organization = current_head.organizations.new(params[:organization])
    if @organization.save
      flash[:success] = 'Organization has been created'
      redirect_to organizations_dashboard_path('index')
    else
      render 'new_organization'
    end
  end

  def edit_organization
   # 
  end

  def switch_organization
    org = current_head.organizations.find(params[:organization_id])
    if org
      session[:current_org_id] = params[:organization_id]
    else
      flash[:error] = 'Unable to switch to the specified organization'
    end

    redirect_to organizations_dashboard_path('index')
  end
end
