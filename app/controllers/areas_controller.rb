class AreasController < ApplicationController
  before_action :authenticate_user!
  before_action :area, only: [:show, :edit, :update, :destroy]
  before_filter :ensure_owner, only: [:destroy, :update]

  respond_to :html

  def index
    @areas = Area.all
    respond_with(@areas)
  end

  def show
    respond_with(@area)
  end

  def join
    respond_with(current_user.areas << area)
  end

  def new
    @area = Area.new
    respond_with(@area)
  end

  def edit
  end

  def create
    @area = Area.new(area_params)
    @area.save
    respond_with(@area)
  end

  def update
    @area.update(area_params)
    respond_with(@area)
  end

  def destroy
    # We dont want to loose history, just change ownership
    unless current_user.admin?
      @new_owner = area.users.where("user_id not in (?)", area.users.where("user_id == ?", current_user.id)).first
      # return only if there is a new owner to be found, otherwise delete it.
      # TODO: Add notification of new owner
      return respond_with area.update_attribute :owner, @new_owner if @new_owner
    end

    @area.destroy
    respond_with(@area)
  end

  private
  def area
    @area ||= Area.find(params[:id])
  end

  def area_params
    params.require(:area).permit(:name, :description, :owner_id)
  end

  def ensure_owner
    current_user.owned_areas.include? @area
  end

end
