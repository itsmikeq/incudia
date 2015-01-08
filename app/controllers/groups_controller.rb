class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_filter :ensure_owner, only: [:destroy]

  # TODO: put in some permissions here on who can access what
  # Permissions levels on focalpoints

  respond_to :html

  def index
    @groups = Group.all
    respond_with(@groups)
  end

  def show
    respond_with(@group)
  end

  def new
    @group = Group.new
    respond_with(@group)
  end

  def edit
  end

  def create
    @group = Group.new(group_params)
    @group.save
    respond_with(@group)
  end

  def update
    @group.update(group_params)
    respond_with(@group)
  end

  def destroy
    @group.destroy
    respond_with(@group)
  end

  private

  def ensure_owner
    current_user.groups.include? @focalpoint
  end

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :description, :owner_id, :owner_type, :visibility_level)
  end
end
