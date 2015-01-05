class SocialNetsUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_social_nets_user, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @social_nets_users = SocialNetsUser.all
    respond_with(@social_nets_users)
  end

  def show
    respond_with(@social_nets_user)
  end

  def new
    @social_nets_user = SocialNetsUser.new
    respond_with(@social_nets_user)
  end

  def edit
  end

  def create
    @social_nets_user = SocialNetsUser.new(social_nets_user_params.merge!(user: current_user))
    @social_nets_user.save
    respond_with(@social_nets_user)
  end

  def update
    # TODO: validate user
    @social_nets_user.update(social_nets_user_params)
    respond_with(@social_nets_user)
  end

  def destroy
    @social_nets_user.destroy
    respond_with(@social_nets_user)
  end

  private
    def set_social_nets_user
      @social_nets_user = SocialNetsUser.find(params[:id])
    end

    def social_nets_user_params
      params.require(:social_nets_user).permit(:social_net_id)
    end
end
