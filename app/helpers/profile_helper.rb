module ProfileHelper
  def oauth_active_class(provider)
    if current_user.provider == provider.to_s
      'active'
    end
  end

  def show_profile_username_tab?
    true # stub.  Need to determine if username chaning is enabled
  end

  def show_profile_social_tab?
    enabled_social_providers.any? && !current_user.ldap_user?
  end

  def show_profile_remove_tab?
    Incudia.config.signup_enabled && !current_user.ldap_user?
  end
end
