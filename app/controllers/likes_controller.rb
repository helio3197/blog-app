class LikesController < ApplicationController
  def create
    @like = Like.new(author: current_user, post: Post.find(params[:post_id]))

    respond_to do |format|
      if @like.save
        format.html do
          redirect_back(fallback_location: user_post_path(params[:user_id], params[:post_id]), notice: 'Liked')
        end
      else
        format.html do
          redirect_back(fallback_location: user_post_path(params[:user_id], params[:post_id]),
                        status: :unprocessable_entity)
        end
      end
    end
  end

  def destroy
    @like = Like.find_by(author: params[:user_id], post: params[:post_id])

    @like.destroy

    respond_to do |format|
      format.html do
        redirect_back(fallback_location: user_post_path(params[:user_id], params[:post_id]), notice: 'Disliked.')
      end
    end
  end
end
