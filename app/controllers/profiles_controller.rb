class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]
  before_action :profile_owner!, only: [:edit, :update]

  def show
    @posts = @user.posts
  end

  def edit
    @profile = @user.profile
  end

  def update
    @profile = current_user.profile

    respond_to do |format|
      if @profile.update(profile_params)
        format.html { 
          redirect_to [:edit, @user, :profile]
        }
        format.js   {}
        format.json { 
          render json: @profile, status: :created, location: [:edit, @user, :profile]
        }
      else
        format.html { 
          render action: "edit"
        }
        format.js   {}
        format.json { 
          render json: @profile.errors, status: :unprocessable_entity 
        }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def profile_owner!
    authenticate_user!

    if @user.profile.id != current_user.profile.id
      redirect_to [@user, @user.profile]
    end
  end

  def profile_params
    params.require(:profile).permit(:gender, :birthday, :location, :note)
  end
end
