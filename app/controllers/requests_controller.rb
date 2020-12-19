class RequestsController < ApplicationController
  before_action :set_pet_and_user, only: [:new, :create]

  def index
    @requests = Request.where(user_id: current_user)
    @all_requests = Request.all
  end

  def new
    @request = Request.new
  end

  def create
    @request = Request.new
    @request.pet = @pet
    @request.user = @user
    if @request.save
      redirect_to request_messages_path(@request), notice: "Request sent to the owner!"
    else
      redirect_to pet_path(@pet), notice: @request.errors.full_messages.last
    end
  end

  def destroy
    @request.destroy
    redirect_to root_path
  end

  private

  def request_params
    params.require(:pet).permit(:pet_id, :user_id)
  end

  def set_pet_and_user
    @pet = Pet.find(params[:pet_id])
    @user = current_user
  end
end
