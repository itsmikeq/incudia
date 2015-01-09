# When hitting the #join or #leave methods,
# this is somewhat of a polymorphic class where if you call it with a /group/ path then it acts as a group

class MembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :membership, only: [:show, :edit, :update, :destroy]
  before_action :klass, only: [:join, :leave, :index]

  # TODO: Make this into a service matcher for all user->group-like relations
  # TODO: Funnel all join/leave operations through here
  respond_to :html

  def index
    # puts "Found group: #{klass.find_by(name: URI.decode(params[:name])).inspect}"
    # @memberships = current_user.memberships.where(of_type: klass.name)
    @memberships = current_user.memberships.where(of_type: klass.name)
    respond_with(@memberships)
  end

  def show
    @membership = current_user.memberships.where(of_type: klass.name)
    respond_with(@membership)
  end

  # Unneeded
  def new
  end

  # Unneeded?
  def edit
  end

  # Creating a new membership is disabled as its handled through calling as /interest/:name/join
  def create
  end

  def update
    # TODO: Allow updating of visibility level and a user's role
  end

  def destroy
  end

  def search
    current_user.memberships.where(of: { name: params[:name] })
  end

  def join
    # TODO: update groups, etc. when the owner joins
    # TODO: send notifications
    Membership.create of: klass.find_by(name: URI.decode(params[:name])), member: current_user
  end

  def leave
    # TODO: update groups, etc. when the owner leaves
    # TODO: send notifications
    current_user.memberships.where(of: klass.find_by(name: URI.decode(params[:name])))
  end

  private

  def klass
    @klass ||= case request.env['PATH_INFO']
      when /group/
        Group
      when /interest/
        Interest
      when /area/
        Area
      when /company/
        Company
      else
        Membership
    end
  end

  def membership
    @membership ||= Membership.find(params[:id])
  end

  def membership_params
    params.require(:membership).permit(:member_id, :of_id, :of_type)
  end

end