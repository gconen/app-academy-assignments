class CatsController < ApplicationController
  before_action :redirect_if_wrong_user, only: [:edit, :update]
  before_action :redirect_unless_logged_in, only: [:create, :new]


  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    @cat_rental_requests = @cat.cat_rental_requests
                            .includes(:cat_owner, :requestor)
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  def destroy
    @cat = Cat.find(params[:id])
    @cat.destroy
    redirect_to cats_url
  end

  private

  def cat_params
    params.require(:cat).permit(:name, :sex, :color, :description, :birth_date)
  end

  def redirect_if_wrong_user
    cat = Cat.find(params[:id])
    redirect_to cats_url unless cat.owner == current_user
  end

end
