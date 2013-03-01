class Organizations::AwsTokensController < Organizations::ApplicationController
  def index
    @tokens = AwsToken.all
  end

  def new
    @has_aws_key = current_organization.has_amazon_credentials?
    @actions = AwsToken::ACTIONS
    @token = AwsToken.new
  end

  def create
    user = User.find(params[:aws_token][:user_id])
    period = params[:aws_token][:period]

    @token = AwsToken.new params[:aws_token].except(:actions)
    @actions = AwsToken::ACTIONS
    @has_aws_key = current_organization.has_amazon_credentials?

    if !params[:aws_token][:actions]
      flash.now[:error] = 'you must specifiy at least one allowed action'
      return render('new')
    else
      actions = params[:aws_token][:actions]
      @token.link = Amazon.create_access_token(current_organization, user.email,
                                               period.to_i, actions)
      if @token.save
        event.info(:message => "Token with ID #{@token.id} created")
        redirect_to organizations_aws_tokens_path
      else
        render :new
      end
    end
  end

  def destroy
    @token = AwsToken.find(params[:id])
    @token.destroy
    event.info(:message => "Token with ID #{@token.id} deleted")
    redirect_to organizations_aws_tokens_path
  end
end
