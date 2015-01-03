class ProfilesController < ApplicationController
  include ActionView::Helpers::SanitizeHelper

  before_filter :user
  skip_before_filter :require_email, only: [:show, :update]

  layout 'profile'

  def show
  end

  def design
  end

  def update

    if @user.update_attributes(user_params)
      flash[:notice] = "Profile was successfully updated"
    else
      flash[:alert] = "Failed to update profile"
    end

    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def reset_private_token
    if current_user.reset_authentication_token!
      flash[:notice] = "Token was successfully updated"
    end

    redirect_to profile_account_path
  end

  def history
    @events = current_user.recent_events.page(params[:page]).per(20)
  end

  def update_username
    @user.update_attributes(username: user_params[:username])

    respond_to do |format|
      format.js
    end
  end

  private

  def user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(
      :email, :password, :password_confirmation, :name, :username
    )
  end
end
