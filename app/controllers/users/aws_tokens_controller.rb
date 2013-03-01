class Users::AwsTokensController < Users::ApplicationController
  def index
    @tokens = current_user.aws_tokens
  end
end
