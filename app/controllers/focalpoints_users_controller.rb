class FocalpointsUsersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_focalpoints_user, only: [:show, :edit, :update, :destroy]

  respond_to :html

  # TODO: put in some permissions here on who can access what
  # Permissions levels on focalpoints

  def index
    @focalpoints_users = FocalpointsUser.all
    respond_with(@focalpoints_users)
  end

  def show
    respond_with(@focalpoints_user)
  end

  def new
    @focalpoints_user = FocalpointsUser.new
    respond_with(@focalpoints_user)
  end

  def edit
  end

  def create
    @focalpoints_user = FocalpointsUser.new(focalpoints_user_params)
    @focalpoints_user.save
    respond_with(@focalpoints_user)
  end

  def update
    @focalpoints_user.update(focalpoints_user_params)
    respond_with(@focalpoints_user)
  end

  def destroy
    @focalpoints_user.destroy
    respond_with(@focalpoints_user)
  end

  private
    def set_focalpoints_user
      @focalpoints_user = FocalpointsUser.find(params[:id])
    end

    def focalpoints_user_params
      params.require(:focalpoints_user).permit(:user_id, :focalpoint_id, :access_level)
    end
end
