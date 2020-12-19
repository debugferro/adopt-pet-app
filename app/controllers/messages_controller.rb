class MessagesController < ApplicationController
  before_action :set_user_and_request

  def index
    @messages = Message.where(request_id: @request) if policy(@request).view?
  end

  def create
    @message = Message.create(message_params)
    @message.user = @user
    @message.request = @request
    if @message.save
      redirect_to request_messages_path(@request), notice: "Message sent!"
    else
      render :index, warning: "Message not sent!"
    end
  end

  private

  def set_user_and_request
    @user = current_user
    @request = Request.find(params[:request_id])
  end

  def message_params
    params.require(:message).permit(:content, :request_id, :user_id)
  end
end
