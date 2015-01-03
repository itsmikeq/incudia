class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  # def self.provides_callback_for(provider)
  #   class_eval %Q{
  #     def #{provider}
  #       @user = User.find_for_oauth(env["omniauth.auth"], current_user)
  #
  #       if @user.persisted?
  #         sign_in_and_redirect @user, event: :authentication
  #         set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
  #       else
  #         session["devise.#{provider}_data"] = env["omniauth.auth"]
  #         redirect_to new_user_registration_url
  #       end
  #     end
  #   }
  # end

  Incudia.config.omniauth.providers.each do |provider|
    define_method provider['name'] do
      # self.class.provides_callback_for provider["name"]
      handle_omniauth
    end
  end

  def after_sign_in_path_for(resource)
    if resource.email_verified?
      super resource
    else
      finish_signup_path(resource)
    end
  end

  # Extend the standard message generation to accept our custom exception
  def failure_message
    exception = env["omniauth.error"]
    error     = exception.error_reason if exception.respond_to?(:error_reason)
    error     ||= exception.error if exception.respond_to?(:error)
    error     ||= exception.message if exception.respond_to?(:message)
    error     ||= env["omniauth.error.type"].to_s
    error.to_s.humanize if error
  end


  def omniauth_error
    @provider = params[:provider]
    @error    = params[:error]
    render 'errors/omniauth_error', layout: "errors", status: 422
  end

  private

  def handle_omniauth
    if current_user
      # Change a logged-in user's authentication method:
      current_user.identities.create(provider: oauth['provider'], uid: oauth['uid'])
      current_user.extern_uid = oauth['uid']
      current_user.provider   = oauth['provider']
      current_user.save

      redirect_to profile_path
    else
      puts "Oath: #{oauth.inspect}"
      @user = Incudia::OAuth::User.new(oauth)
      @user.save
      unless @user.ic_user.identities.find_by(provider: oauth['provider'], uid: oauth['uid'])
        @user.ic_user.extern_uid = oauth['uid']
        @user.ic_user.provider   = oauth['provider']
        @user.ic_user.save
        # We've authenticated with this account.
        @user.ic_user.identities.create!(provider: oauth['provider'], uid: oauth['uid'])
      end

      # Only allow properly saved users to login.
      if @user.persisted? && @user.valid?
        sign_in_and_redirect(@user.ic_user)
      else
        error_message =
            if @user.ic_user.errors.any?
              @user.ic_user.errors.map do |attribute, message|
                "#{attribute} #{message}"
              end.join(", ")
            else
              ''
            end

        redirect_to omniauth_error_path(oauth['provider'], error: error_message) and return
      end
    end
  rescue StandardError => e
    Rails.logger.error e.message
    flash[:notice] = "There's no such user!"
    redirect_to new_user_session_path
  end

  def oauth
    @oauth ||= request.env['omniauth.auth']
  end
end
