class InterestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_interest, only: [:show, :edit, :update, :destroy]

  # TODO: put in some permissions here on who can access what
  # Permissions levels on focalpoints

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

  def destroy
    @interest.destroy
    respond_with(@interest)
  end

  private
    def set_interest
      @interest = Interest.find(params[:id])
    end

    def interest_params
      params.require(:interest).permit(:name, :description, :type)
    end
end
