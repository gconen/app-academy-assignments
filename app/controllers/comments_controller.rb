class CommentsController < ApplicationController
  def new
    @comment = Comment.new(
                post_id: params[:post_id],
                parent_comment_id: params[:parent_comment_id]
                )
  end

  def create
    @comment = Comment.create(
                content: params[:comment][:content],
                author_id: current_user.id,
                post_id: params[:post_id],
                parent_comment_id: params[:parent_comment_id]
                )
    redirect_to post_url(params[:post_id])
  end
end
