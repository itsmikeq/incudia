class EmbeddedContentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_embedded_content, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @embedded_contents = current_user.embedded_contents
    respond_with(@embedded_contents)
  end

  def show
    respond_with(@embedded_content)
  end

  def new
    @embedded_content = current_user.embedded_contents.new
    respond_with(@embedded_content)
  end

  def edit
  end

  def create
    @embedded_content = current_user.embedded_contents.new(embedded_content_params)
    @embedded_content.save
    respond_with(@embedded_content)
  end

  def update
    @embedded_content.update(embedded_content_params)
    respond_with(@embedded_content)
  end

  def destroy
    @embedded_content.destroy
    respond_with(@embedded_content)
  end

  private
    def set_embedded_content
      @embedded_content = current_user.embedded_contents.find(params[:id])
    end

    def embedded_content_params
      params.require(:embedded_content).permit(:url, :owner_id, :owner_type, :owner_type)
    end
end
