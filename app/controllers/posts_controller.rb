class PostsController < ApplicationController
  def index
    @user = User.includes(:posts, posts: :comments).find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @post = User.find(params[:user_id]).posts.find(params[:id])
    @like = Like.find_by(author: current_user, post: @post)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(**post_params, comments_counter: 0, likes_counter: 0)

    respond_to do |format|
      if @post.save
        format.html { redirect_to user_post_path(current_user, @post), notice: 'Post was successfully created.' }
      else
        flash.now[:notice] = 'Something went wrong.'
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
