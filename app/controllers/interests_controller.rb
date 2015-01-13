class InterestsController < ApplicationController
  before_action :authenticate_user!
  before_action :interest, only: [:show, :edit, :update, :destroy]
  before_filter :ensure_owner, only: [:destroy, :update]

  # TODO: put in some permissions here on who can access what
  # Permissions levels

  respond_to :html

  def index
    @interests = Interest.all
    respond_with(@interests)
  end

  def show
    respond_with(@interest)
  end

  def new
    @interest = Interest.new
    respond_with(@interest)
  end

  def join
    respond_with(current_user.groups << interest)
  end

  def edit
  end

  def create
    @interest = Interest.new(interest_params.merge!(owner: current_user))
    @interest.save
    respond_with(@interest)
  end

  def update
    # TODO: validate user
    @interest.update(interest_params)
    respond_with(@interest)
  end

  def leave
    respond_with current_user.interests.where(id: params[:id]).destroy
  end

  def destroy
    # We dont want to loose history, just change ownership
    unless current_user.admin?
      @new_owner = interest.users.where("user_id not in (?)", interest.users.where("user_id == ?", current_user.id)).first
      # return only if there is a new owner to be found, otherwise delete it.
      # TODO: Add notification of new owner
      return respond_with interest.update_attribute :owner, @new_owner if @new_owner
    end
    @interest.destroy
    respond_with(@interest)
  end

  private
  def ensure_owner
    current_user.owned_interests.include? interest
  end

  def interest
    @interest ||= Interest.find(params[:id])
  end

  def interest_params
    params.require(:interest).permit(:name, :description, :type)
  end
end
