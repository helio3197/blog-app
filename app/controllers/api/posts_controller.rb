class Api::PostsController < ApplicationController
  def index
    user = User.includes(:posts, posts: :comments).find(params[:user_id])
    posts = user.posts

    render json: posts
  end
end
