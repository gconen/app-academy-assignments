class UsersController < ApplicationController
  before_action :redirect_if_not_logged_in, except: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @pending_goals = @user.goals.where(completed: false).includes(:comments)
    @completed_goals = @user.goals.where(completed: true).includes(:comments)
  end

  def edit

  end

  def update

  end

  def destroy

  end

  def index
    @users = User.all
  end

end
