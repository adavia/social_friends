class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :post_owner!, only: [:destroy]

	def index
    @posts = Post.all
    @post = current_user.posts.build
    @post.attachments.build
	end

  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        upload_files
        format.html { 
          redirect_to posts_path 
        }
        format.js   {}
        format.json { 
          render json: @post, status: :created, location: @post 
        }
      else
        @posts = []
        @post.attachments.build
        format.html { 
          render :index 
        }
        format.js   {}
        format.json { 
          render json: @post.errors, status: :unprocessable_entity 
        }
      end
    end
  end

  private

  def post_owner!
    authenticate_user!

    if @post.user.id != current_user.id
      redirect_to posts_path
    end
  end

  def upload_files  
    if params[:attachments] && params[:attachments][:file] != [""]
      params[:attachments][:file].each do |a|
        @attachment = @post.attachments.create!(file: a)
      end
    end 
  end

  def post_params
    params.require(:post).permit(:body, attachments_attributes: [:file])
  end
end
