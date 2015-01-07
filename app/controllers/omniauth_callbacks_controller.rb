class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  Incudia.config.omniauth.providers.each do |provider|
    define_method provider['name'] do
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
      update_identities(current_user)
      redirect_to profile_path
    else
      log.debug "Oath: #{oauth.inspect}"
      @user = Incudia::OAuth::User.new(oauth)
      @user.save
      # @current_user = @user.ic_user
      # Only allow properly saved users to login.
      if @user.persisted? && @user.valid?
        # update_identities(@user.ic_user)
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
        log.warn "#{oauth['provider']} Error: #{error_message}"
        redirect_to omniauth_error_path(oauth['provider'], error: error_message) and return
      end
    end
  rescue StandardError => e
    log.error "Error: #{e.message}"
    flash[:notice] = "There's no such user!"
    redirect_to new_user_session_path
  end

  def update_identities(ic_user)
    puts "Updating identities"
    unless ic_user.identities.find_by(provider: oauth['provider'], uid: oauth['uid']).any?
      ic_user.create(provider: oauth['provider'], uid: oauth['uid'], user: @user.ic_user)
    end
  end

  def oauth
    @oauth ||= request.env['omniauth.auth']
  end

  def log
    Incudia::OAuthLogger
  end

end
