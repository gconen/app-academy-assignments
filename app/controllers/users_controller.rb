class UsersController < ApplicationController
  def create
    # sign up the user
    @user = User.new(user_params)
    if @user.save
      # redirect them to the new user's show page
      redirect_to user_url(@user)
    else
      # input didn't pass validation; re-render sign up form.
      render :new
    end
  end

  def new
    # present form for signup
    @user = User.new # dummy user object
    render :new
  end

  def show
    # show the user's details (just their username)
    @user = User.find(params[:id])
    render :show
  end

  protected
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
