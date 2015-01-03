class BroadcastsController < ApplicationController
  before_action :set_broadcast, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @broadcasts = Broadcast.all
    respond_with(@broadcasts)
  end

  def show
    respond_with(@broadcast)
  end

  def new
    @broadcast = Broadcast.new
    respond_with(@broadcast)
  end

  def edit
  end

  def create
    @broadcast = Broadcast.new(broadcast_params)
    @broadcast.save
    respond_with(@broadcast)
  end

  def update
    @broadcast.update(broadcast_params)
    respond_with(@broadcast)
  end

  def destroy
    @broadcast.destroy
    respond_with(@broadcast)
  end

  private
    def set_broadcast
      @broadcast = Broadcast.find(params[:id])
    end

    def broadcast_params
      params.require(:broadcast).permit(:message, :ends_at, :starts_at, :alert_type, :color, :font)
    end
end
