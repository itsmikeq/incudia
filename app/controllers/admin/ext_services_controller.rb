class Admin::ExtServicesController < ApplicationController
  before_action :set_admin_ext_service, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @admin_ext_services = Admin::ExtService.all
    respond_with(@admin_ext_services)
  end

  def show
    respond_with(@admin_ext_service)
  end

  def new
    @admin_ext_service = Admin::ExtService.new
    respond_with(@admin_ext_service)
  end

  def edit
  end

  def create
    @admin_ext_service = Admin::ExtService.new(ext_service_params)
    @admin_ext_service.save
    respond_with(@admin_ext_service)
  end

  def update
    @admin_ext_service.update(ext_service_params)
    respond_with(@admin_ext_service)
  end

  def destroy
    @admin_ext_service.destroy
    respond_with(@admin_ext_service)
  end

  private
    def set_admin_ext_service
      @admin_ext_service = Admin::ExtService.find(params[:id])
    end

    def admin_ext_service_params
      params.require(:admin_ext_service).permit(:url)
    end
end
