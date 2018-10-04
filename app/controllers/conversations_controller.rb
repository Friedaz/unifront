class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_mailbox

  def index
    @conversations = current_user.mailbox.conversations
  end

  def show
    @conversation = current_user.mailbox.conversations.find(params[:id])
  end

  def new
    @receipients = User.all - [current_user]
  end

  def create
    receipient = User.find(params[:user_id])
    receipt = current_user.send_message(receipient, params[:body], params[:subject])
    redirect_to conversation_path(receipt.conversation)
  end

 private

  def get_mailbox
    @mailbox ||= current_user.mailbox
  end

end
