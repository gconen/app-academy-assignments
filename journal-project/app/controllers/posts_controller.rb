class PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
    render json: @post
  end

  def index
    @posts = Post.all
    render json: @posts
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      render json: @post
    else
      render json: @post.errors.full_messages
    end
  end

  def update
    # sleep 2

    @post = Post.find(params[:id])
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors.full_messages, status: :unprocessible_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    render json: @post
  end

  private
  def post_params
    params.require(:post).permit(:title, :body)
  end
end
