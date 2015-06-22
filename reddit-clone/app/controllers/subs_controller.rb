class SubsController < ApplicationController
  before_action :check_logged_in, except: [:show, :index]
  before_action :verify_moderator, only: [:edit, :update, :destroy]

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def destroy
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def index
    @subs = Sub.all
  end

  def show
    @sub = Sub.find(params[:id])
    @posts = @sub.posts.includes(:author)
    @new_post = Post.new
    @new_post.subs = [@sub]
  end

  def verify_moderator
    @sub = Sub.find(params[:id])
    flash[:errors] = ["You cannot edit this sub"]
    redirect_to sub_url(@sub) if @sub.moderator_id != current_user.id
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
