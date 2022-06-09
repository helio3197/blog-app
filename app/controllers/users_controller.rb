class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @last_posts = User.last_three_posts @user
  end
end
