class Organizations::TokensController < Organizations::ApplicationController
  def index
    @tokens = Token.all
  end

  def new
    @token = Token.new
  end

  def create
    @token = Token.new(params[:token])
    if @token.save
      event.info(:message => "Token with ID #{@token.id} created")
      redirect_to organizations_tokens_path
    else
      render :new
    end
  end

  def edit
    @token = Token.find(params[:id])
  end

  def update
    @token = Token.new
    if @token.update_attributes(params[:token])
      event.info(:message => "Token with ID #{@token.id} updated")
      redirect_to organizations_tokens_path
    else
      render :edit
    end
  end

  def destroy
    @token = Token.find(params[:id])
    @token.destroy
    event.info(:message => "Token with ID #{@token.id} deleted")
    redirect_to organizations_tokens_path
  end
end
