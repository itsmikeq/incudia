class EmailsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_email, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @emails = current_user.emails
    respond_with(@emails)
  end

  def show
    respond_with(@email)
  end

  def new
    @email = current_user.emails.new
    respond_with(@email)
  end

  def edit
  end

  def create
    @email = current_user.emails.new(email_params)
    @email.save
    respond_with(@email)
  end

  def update
    @email.update(email_params)
    respond_with(@email)
  end

  def destroy
    @email.destroy
    respond_with(@email)
  end

  private
    def set_email
      @email = current_user.find(params[:id])
    end

    def email_params
      params.require(:email).permit(:user_id, :email)
    end
end
