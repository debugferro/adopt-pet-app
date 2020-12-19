class PetsController < ApplicationController
  before_action :set_pet, only: [:show, :edit, :update, :destroy]
  before_action :set_request_for_message_link, only: [:show]

  def index
    @pets = policy_scope(Pet).order(created_at: :desc).where(adopted: false)
  end

  def show
    authorize @pet
    @pet = Pet.find(params[:id])
    @request = Request.new
    # Getting all the requests to show if action authorized
    @requests = Request.where(pet_id: @pet) if policy(@pet).list_requests?
    if policy(@pet).show_message_link?
      @my_request = Request.where(pet_id: @pet, user_id: current_user).first
      @created_at = @my_request.created_at.to_time.strftime('%B %e of %Y')
      @updated_at = @my_request.updated_at.to_time.strftime('%B %e of %Y')
    end
    if @pet.adopted == true
      @adoption = Request.where(pet_id: @pet, finished: true).first
      @who_adopted = @adoption.user
      @when_adopted = @adoption.updated_at.to_time.strftime('%B %e of %Y')
    end
  end

  def new
    @pet = Pet.new
    authorize @pet
  end

  def create
    @pet = Pet.new(pet_params)
    authorize @pet
    @pet.user = current_user

    if @pet.save
      redirect_to pet_path(@pet)
    else
      render :new
    end
  end

  def edit
    authorize @pet
  end

  def update
    if @pet.update(pet_params)
      authorize @pet
      set_request_finished if params[:pet][:finished]
      set_request_unfinished if params[:pet][:unfinished]
      redirect_to pet_path(@pet), notice: "Pet updated!"
    else
      render :edit
    end
  end

  def destroy
    authorize @pet
    @pet.destroy
    redirect_to root_path
  end

  private

  def set_pet
    @pet = Pet.find(params[:id])
  end

  def set_request_finished
    request = Request.find(params[:pet][:finished])
    request.finished = true
    request.save!
  end

  def set_request_unfinished
    request = Request.find(params[:pet][:unfinished])
    request.finished = false
    request.save!
  end

  # => Getting pet requests
  def set_request_for_message_link
    @request_link = Request.where(pet_id: @pet, user_id: current_user)
  end

  def pet_params
    params.require(:pet).permit(:name, :photo, :found_date, :description,
                                :species, :breed, :size, :age,
                                :state, :city, :neighborhood, :adopted)
  end
end
