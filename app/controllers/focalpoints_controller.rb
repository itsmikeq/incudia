class FocalpointsController < ApplicationController
  before_action :authenticate_user!
  before_action :focalpoint, only: [:show, :edit, :update, :destroy]
  before_filter :ensure_logged_in, only: [:new, :create, :edit, :update]
  before_filter :ensure_owner, only: [:destroy, :update]

  respond_to :html

  def index
    @focalpoints = Focalpoint.all
    respond_with(@focalpoints)
  end

  def show
    respond_with(@focalpoint)
  end

  def join
    respond_with(current_user.focalpoints << focalpoint)
  end

  def new
    @focalpoint = current_user.focalpoints.new
    respond_with(@focalpoint)
  end

  def edit
  end

  def create
    @focalpoint = current_user.focalpoints.new(focal_params.merge!(owner: current_user))
    @focalpoint.save
    respond_with(@focalpoint)
  end

  def update
    # TODO: Validate user
    @focalpoints.update(focal_params)
    respond_with(@focalpoint)
  end

  def destroy
    # We dont want to loose history, just change ownership
    unless current_user.admin?
      @new_owner = focalpoint.users.where("user_id not in (?)", focalpoint.users.where("user_id == ?", current_user.id)).first
      # return only if there is a new owner to be found, otherwise delete it.
      # TODO: Add notification of new owner
      return respond_with focalpoint.update_attribute :owner, @new_owner if @new_owner
    end

    @focalpoint.destroy
    respond_with(@focalpoint)
  end

  private

  def ensure_owner
    current_user.focalpoints.include? @focalpoint
  end

  def focalpoint
    @focalpoint ||= Focalpoint.find(params[:id])
  end

  def focal_params
    params.require(:focalpoints).permit(:area_id, :area_type, :name, :description, :owner_id, :owner_type, :visibility_level)
  end

end
