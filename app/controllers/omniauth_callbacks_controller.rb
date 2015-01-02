class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  Incudia.config.omniauth.providers.each do |provider|
    define_method provider['name'] do
      handle_omniauth
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
      current_user.extern_uid = oauth['uid']
      current_user.provider   = oauth['provider']
      current_user.save
      redirect_to profile_path
    else
      @user = Incudia::OAuth::User.new(oauth)
      @user.save

      # Only allow properly saved users to login.
      if @user.persisted? && @user.valid?
        sign_in_and_redirect(@user.gl_user)
      else
        error_message =
            if @user.gl_user.errors.any?
              @user.gl_user.errors.map do |attribute, message|
                "#{attribute} #{message}"
              end.join(", ")
            else
              ''
            end

        redirect_to omniauth_error_path(oauth['provider'], error: error_message) and return
      end
    end
  rescue StandardError
    flash[:notice] = "There's no such user!"
    redirect_to new_user_session_path
  end

  def oauth
    @oauth ||= request.env['omniauth.auth']
  end
end
