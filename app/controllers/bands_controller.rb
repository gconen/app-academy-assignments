class BandsController < ApplicationController
  before_action :redirect_unless_logged_in

  def show
    @band = Band.find(params[:id])
  end

  def new
    @band = Band.new
  end

  def index
    @bands = Band.all
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      redirect_to band_url(@band)
    else
      flash.now[:errors] = @band.errors.full_messages
      render :new
    end
  end

  def edit
    @band = Band.find(params[:id])
  end

  def update
    @band = Band.find(params[:id])
    if @band.update(band_params)
      redirect_to band_url(@band)
    else
      flash.now[:errors] = @band.errors.full_messages
      render :edit
    end
  end

  def destroy
    Band.find(params[:id]).destroy
    redirect_to :back
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end
end
