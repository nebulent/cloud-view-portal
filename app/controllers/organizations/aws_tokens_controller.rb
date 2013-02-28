class Organizations::AwsTokensController < Organizations::ApplicationController
  def index
    @tokens = AwsToken.all
  end

  def new
    @token = AwsToken.new
  end

  def create
    @token = AwsToken.new(params[:token])
    if @token.save
      event.info(:message => "Token with ID #{@token.id} created")
      redirect_to organizations_aws_tokens_path
    else
      render :new
    end
  end

  def edit
    @token = AwsToken.find(params[:id])
  end

  def update
    @token = AwsToken.new
    if @token.update_attributes(params[:token])
      event.info(:message => "Token with ID #{@token.id} updated")
      redirect_to organizations_aws_tokens_path
    else
      render :edit
    end
  end

  def destroy
    @token = AwsToken.find(params[:id])
    @token.destroy
    event.info(:message => "Token with ID #{@token.id} deleted")
    redirect_to organizations_aws_tokens_path
  end
end
