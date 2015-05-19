class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    if params[:user_id]
      @comment.commentable_id = params[:user_id]
      @comment.commentable_type = "User"
    else
      @comment.commentable_id = params[:goal_id]
      @comment.commentable_type = "Goal"
    end
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    if @comment.save
      if @comment.commentable_type == "User"
        redirect_to user_url(@comment.commentable_id)
      else
        redirect_to user_url(@comment.commentable.user_id)
      end
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def comment_params
    params.require(:comment).permit(:commentable_id, :commentable_type,
                                    :body)
  end
end
