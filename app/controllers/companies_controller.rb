class CompaniesController < ApplicationController
  before_action :authenticate_user!
  before_action :company, only: [:show, :edit, :update, :destroy]
  before_filter :ensure_owner, only: [:destroy, :update]

  respond_to :html, :json

  def index
    @companies = Company.all
    respond_with(@companies)
  end

  def show
    respond_with(@company)
  end

  def join
    respond_with(current_user.companies << company)
  end

  def new
    @company = Company.new
    respond_with(@company)
  end

  def edit
  end

  def create
    @company = Company.new(company_params.merge!(owner: current_user))
    @company.save
    respond_with(@company)
  end

  def update
    # TODO: Validate owner
    @company.update(company_params)
    respond_with(@company)
  end

  def destroy
    # We dont want to loose history, just change ownership
    unless current_user.admin?
      @new_owner = company.users.where("user_id not in (?)", company.users.where("user_id == ?", current_user.id)).first
      # return only if there is a new owner to be found, otherwise delete it.
      # TODO: Add notification of new owner
      return respond_with company.update_attribute :owner, @new_owner if @new_owner
    end
    @company.destroy
    respond_with(@company)
  end

  private
  def ensure_owner
    current_user.companies.include? @focalpoint
  end

  def company
    @company ||= Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :description)
  end
end
