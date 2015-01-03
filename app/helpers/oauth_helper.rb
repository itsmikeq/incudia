module OauthHelper

  def default_providers
    [:twitter, :github, :google_oauth2, :ldap]
  end

  def enabled_oauth_providers
    Devise.omniauth_providers + SocialNet.pluck(:name)
  end

  def enabled_social_providers
    enabled_oauth_providers.select do |name|
      [:twitter, :github, :google_oauth2].include?(name.to_sym)
    end
  end

end
