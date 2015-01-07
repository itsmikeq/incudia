module OauthHelper

  def static_providers
    Devise.omniauth_providers
  end

  def enabled_oauth_providers
    ( static_providers + SocialNet.pluck(:name)).uniq
  end

  def enabled_social_providers
    # TODO: Mix this in with SocialNet
    static_providers
  end

end
