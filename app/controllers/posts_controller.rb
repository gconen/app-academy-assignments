class PostsController < ApplicationController
  before_action :check_logged_in, except: [:show]
  before_action :verify_post_author, only: [:edit, :update]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
    @author = @post.author
    @all_comments = @post.comments.includes(:author)
    @new_comment = Comment.new(post_id: @post.id)
  end

  private

  def verify_post_author
    @post = Post.find(params[:id])
    if @post.author_id != current_user.id
      flash[:errors] = ["You can't edit that post"]
      redirect_to post_url(@post)
    end
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
end
