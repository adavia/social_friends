class AttachmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_attachable
  before_action :user_owner!, only: [:create, :primary]

  def index
    @attachments = @attachable.attachments
    @attachment = current_user.attachments.build
  end

  def show
    @attachment = @attachable.attachments.find(params[:id])
    render layout: !request.xhr?
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

  def primary
    respond_to do |format|
      if @attachable.class == User
        @attachment = Attachment.find(params[:id])
        @attachment.make_default!(current_user)
        format.html { 
          redirect_to [@attachable, @attachment]
        }        
        format.js   {}
      end
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
