class Api::CommentsController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    user = User.includes(:posts, posts: :comments).find(params[:user_id])
    post = user.posts.find(params[:post_id])
    comments = post.comments

    render json: comments
  end

  def create
    user = User.find(3)

    comment = Comment.create(**comment_params, author: user, post_id: params[:post_id])

    render json: comment, status: :created
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
