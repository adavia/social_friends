class AttachmentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :set_attachable, only: [:show, :create]
  before_action :user_owner!, only: [:create]

  def show
    @attachments = @attachable.attachments
    @attachment = current_user.attachments.build
  end

  def create
    respond_to do |format|
      upload_files
      format.html { 
        redirect_to [@attachable, :attachments]
      }
      format.js   {}
      format.json { 
        render json: @attachment, status: :created, location: [@attachable, :attachments]
      }
    end
  end

  private

  def set_attachable
    klass = [User, Post].detect { |c| params["#{c.name.underscore}_id"] }
    @attachable = klass.find(params["#{klass.name.underscore}_id"])
  end

  def user_owner!
    authenticate_user!

    if @attachable != current_user
      redirect_to [@attachable, @attachable.profile]
    end
  end

  def upload_files  
    if params[:attachments] && params[:attachments][:file] != [""]
      @attachments = []
      params[:attachments][:file].each do |a|
        @attachments << @attachable.attachments.create!(file: a)
      end
    end 
  end

  def attachment_params
    params.require(:attachments).permit(:file)
  end
end 
