class Api::CommentsController < ApplicationController
  def index
    user = User.includes(:posts, posts: :comments).find(params[:user_id])
    post = user.posts.find(params[:post_id])
    comments = post.comments

    render json: comments
  end
end
