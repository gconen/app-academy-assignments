class BandsController < ApplicationController
  def show
    @band = Band.find(:id)
  end

  def new
    @band = Band.new
  end

  
end
