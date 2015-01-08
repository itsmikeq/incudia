class MembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :membership, only: [:show, :edit, :update, :destroy]

  # TODO: Make this into a service matcher for all user->group-like relations
  # TODO: Funnel all join/leave operations through here
  respond_to :html

  def index
    @memberships = Membership.all
    respond_with(@memberships)
  end

  def show
    respond_with(@membership)
  end

  def new
    @membership = Membership.new
    respond_with(@membership)
  end

  def edit
  end

  def create
    @membership = Membership.new(membership_params)
    @membership.save
    respond_with(@membership)
  end

  def update
    @membership.update(membership_params)
    respond_with(@membership)
  end

  def destroy
    @membership.destroy
    respond_with(@membership)
  end

  private
    def membership
      @membership ||= Membership.find(params[:id])
    end

    def membership_params
      params.require(:membership).permit(:member_id, :of_id, :of_type)
    end
end
