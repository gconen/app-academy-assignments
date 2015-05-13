class CatRentalRequestsController < ApplicationController
  before_action :redirect_unless_cat_owner, only: [:approve, :deny]
  before_action :redirect_unless_logged_in, only: [:create, :new]

  def show
    @request = CatRentalRequest.find(params[:id])
    @cat = @request.cat
    render :show
  end

  def index
    @cat_rental_requests = CatRentalRequest.all
    render :index
  end

  def new
    if params[:cat_id]
      @cat_rental_request = CatRentalRequest.new(cat_id: params[:cat_id])
    else
      @cat_rental_request = CatRentalRequest.new
    end
    render :new
  end

  def create
    @cat_rental_request = CatRentalRequest.new(request_params)
    @cat_rental_request.user_id = current_user.id
    if @cat_rental_request.save
      redirect_to cat_rental_request_url(@cat_rental_request)
    else
      flash.now[:errors] = @cat_rental_request.errors.full_messages
      render :new
    end
  end

  def edit
    @cat_rental_request = CatRentalRequest.find(params[:id])
    render :edit
  end

  def update
    @cat_rental_request = CatRentalRequest.find(params[:id])
    @cat_rental_request.status = "PENDING"
    if @cat_rental_request.update(request_params)
      redirect_to cat_rental_request_url(@cat_rental_request)
    else
      flash.now[:errors] = @cat_rental_request.errors.full_messages
      render :edit
    end
  end

  def approve
    @request = CatRentalRequest.find(params[:id])
    @request.approve!
    redirect_to :back
  end

  def deny
    @request = CatRentalRequest.find(params[:id])
    @request.deny!
    redirect_to :back
  end

  private

  def redirect_unless_cat_owner
    request = CatRentalRequest.find(params[:id])
    if request.cat_owner != current_user
      flash[:errors] = ["You don't own that cat"]
      redirect_to :back
    end
  end

  def request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end

end
