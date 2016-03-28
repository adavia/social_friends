class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def follow
    respond_to do |format|
      current_user.follow!(@user)
      format.html { 
        redirect_to [@user, :profile]
      }
      format.js   {}
    end
  end

  def unfollow
    respond_to do |format|
      current_user.unfollow!(@user)
      format.html { 
        redirect_to [@user, :profile]
      }
      format.js   {}
    end
  end

  def followers
    @users = @user.followers
  end

  def following
    @users = @user.leaders
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end