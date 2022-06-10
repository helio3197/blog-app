class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @post = User.find(params[:user_id]).posts.find(params[:id])
    @like = Like.find_by(author: @post.author, post: @post)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(**post_params, author: current_user, comments_counter: 0, likes_counter: 0)

    respond_to do |format|
      if @post.save
        format.html { redirect_to user_post_path(current_user, @post), notice: 'Post was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
