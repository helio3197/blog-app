class CommentsController < ApplicationController
  def create
    @comment = Comment.new(**comment_params, author: current_user, post: Post.find(params[:post_id]))

    respond_to do |format|
      if @comment.save
        format.html do
          redirect_back(fallback_location: user_post_path(params[:user_id], params[:post_id]),
                        notice: 'Comment successfully created.')
        end
      else
        format.html do
          redirect_back(fallback_location: user_post_path(params[:user_id], params[:post_id]),
                        status: :unprocessable_entity, notice: 'Failed to add new comment.')
        end
      end
    end
  end

  def destroy
    Comment.find(params[:id]).destroy

    respond_to do |format|
      format.html do
        redirect_back(fallback_location: user_post_path(params[:user_id], params[:post_id]),
                      notice: 'Comment successfully deleted.')
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
