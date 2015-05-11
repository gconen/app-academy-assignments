class UsersController < ApplicationController
  def index
    render json: User.all
  end

  def create
    render json: "I'm in the create action!".to_json
  end

  def show
    render json: params.to_json
  end

end
