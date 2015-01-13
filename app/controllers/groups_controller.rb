class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :group, only: [:show, :edit, :update, :destroy]
  before_filter :ensure_owner, only: [:destroy, :update]

  # TODO: put in some permissions here on who can access what

  respond_to :html

  def index
    @groups = Group.all
    respond_with(@groups)
  end

  def join
    respond_with(current_user.groups << group)
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
    # We dont want to loose history, just change ownership
    unless current_user.admin?
      @new_owner = group.users.where("user_id not in (?)", group.users.where("user_id == ?", current_user.id)).first
      # return only if there is a new owner to be found, otherwise delete it.
      # TODO: Add notification of new owner
      return respond_with group.update_attribute :owner, @new_owner if @new_owner
    end
    @group.destroy
    respond_with(@group)
  end

  private

  def ensure_owner
    current_user.owned_groups.include? @group
  end

  def group
    @group ||= Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :description, :owner_id, :owner_type, :visibility_level)
  end
end
