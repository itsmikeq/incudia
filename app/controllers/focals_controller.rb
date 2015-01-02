class FocalsController < ApplicationController
  before_action :set_focal, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @focals = Focal.all
    respond_with(@focals)
  end

  def show
    respond_with(@focal)
  end

  def new
    @focal = Focal.new
    respond_with(@focal)
  end

  def edit
  end

  def create
    @focal = Focal.new(focal_params)
    @focal.save
    respond_with(@focal)
  end

  def update
    @focal.update(focal_params)
    respond_with(@focal)
  end

  def destroy
    @focal.destroy
    respond_with(@focal)
  end

  private
    def set_focal
      @focal = Focal.find(params[:id])
    end

    def focal_params
      params.require(:focal).permit(:area_id, :area_type, :name, :description, :owner_id, :owner_type, :visibility_level)
    end
end
