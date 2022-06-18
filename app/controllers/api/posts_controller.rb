class Api::PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    user = User.includes(:posts, posts: :comments).find(params[:user_id])
    posts = user.posts

    render json: posts
  end
end
