class AlbumsController < ApplicationController
  before_action :redirect_unless_logged_in

  def show
    @album = Album.find(params[:id])
  end

  def index
    @albums = Album.all
  end

  def new
    @album = Album.new(band_id: params[:band_id])
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  def destroy
    Band.find(params[:id]).destroy
    redirect_to :back
  end

  private

  def album_params
    params.require(:album).permit(:title, :band_id, :live)
  end
end
