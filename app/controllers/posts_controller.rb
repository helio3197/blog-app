class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
    # @last_comments = Post.last_five_comments()
  end

  def show; end
end
