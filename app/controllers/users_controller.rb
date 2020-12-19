class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def show_my_posts
    @user = User.find(params[:user_id])
    if policy(@user).show_page?
      @requests = Request.where(finished: true)
      @pets = Pet.where(user_id: current_user)
    else
      @user = nil
      @pets = nil
    end
  end
end
