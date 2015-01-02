class NamespacesController < ApplicationController
  before_action :set_namespace, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @namespaces = Namespace.all
    respond_with(@namespaces)
  end

  def show
    respond_with(@namespace)
  end

  def new
    @namespace = Namespace.new
    respond_with(@namespace)
  end

  def edit
  end

  def create
    @namespace = Namespace.new(namespace_params)
    @namespace.save
    respond_with(@namespace)
  end

  def update
    @namespace.update(namespace_params)
    respond_with(@namespace)
  end

  def destroy
    @namespace.destroy
    respond_with(@namespace)
  end

  private
    def set_namespace
      @namespace = Namespace.find(params[:id])
    end

    def namespace_params
      params.require(:namespace).permit(:name, :description, :owner_id, :owner_type, :type)
    end
end
