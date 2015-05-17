class CountersController < ApplicationController
  def update
    if params[:user][:counter]
      current_user.counter = params[:user][:counter]
    else
      current_user.counter = 0
    end
    current_user.save!
    redirect_to user_url
  end
end
