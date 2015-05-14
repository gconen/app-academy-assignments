class TracksController < ApplicationController
  before_action :redirect_unless_logged_in

  def show
    @track = Track.find(params[:id])
  end

  def index
    @tracks = Track.all
  end

  def new
    @track = Track.new
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def edit
    @track = Track.find(params[:id])
  end

  def update
    @track = Track.find(params[:id])
    if @track.update(track_params)
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :edit
    end
  end

  def destroy
    Band.find(params[:id]).destroy
    redirect_to :back
  end

  private

  def track_params
    params.require(:track).permit(:album_id, :title, :lyrics, :bonus)
  end
end
