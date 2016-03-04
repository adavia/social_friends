class PagesController < ApplicationController
  before_action :set_page, only: [:index]

  def index
  end

  private
    def set_page
      redirect_to posts_path if current_user
    end
end
