class FocalpointsController < ApplicationController
  before_action :set_focal, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @focalpoints = Focalpoint.all
    respond_with(@focalpoints)
  end

  def show
    respond_with(@focalpoints)
  end

  def new
    @focalpoints = Focalpoint.new
    respond_with(@focalpoints)
  end

  def edit
  end

  def create
    @focalpoints = Focalpoint.new(focal_params)
    @focalpoints.save
    respond_with(@focalpoints)
  end

  def update
    @focalpoints.update(focal_params)
    respond_with(@focalpoints)
  end

  def destroy
    @focalpoints.destroy
    respond_with(@focalpoints)
  end

  private
    def set_focal
      @focalpoints = Focalpoint.find(params[:id])
    end

    def focal_params
      params.require(:focalpoints).permit(:area_id, :area_type, :name, :description, :owner_id, :owner_type, :visibility_level)
    end
end
