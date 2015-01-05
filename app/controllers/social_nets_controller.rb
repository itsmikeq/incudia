class SocialNetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_social_net, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @social_nets = SocialNet.all
    respond_with(@social_nets)
  end

  def show
    respond_with(@social_net)
  end

  def new
    @social_net = SocialNet.new
    respond_with(@social_net)
  end

  def edit
  end

  def create
    @social_net = SocialNet.new(social_net_params)
    @social_net.save
    respond_with(@social_net)
  end

  def update
    @social_net.update(social_net_params)
    respond_with(@social_net)
  end

  def destroy
    @social_net.destroy
    respond_with(@social_net)
  end

  private
    def set_social_net
      @social_net = SocialNet.find(params[:id])
    end

    def social_net_params
      params.require(:social_net).permit(:name, :api_url)
    end
end
