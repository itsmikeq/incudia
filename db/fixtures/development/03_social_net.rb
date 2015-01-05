Incudia::Seeder.quiet do
  def endpoint_secret(endpoint)
    Devise.omniauth_configs[endpoint].instance_variable_get(:@strategy)[:client_secret]
  rescue
    nil
  end

  endpoints = {
      github:   {api: "https://api.github.com/$username/$project"},
      linkedin: {api: "https://api.linkedin.com/v1/people/$username"},
      facebook: {api: "https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.0&appId=#{endpoint_secret(:facebook)}"},
      google:   {api: "https://apis.google.com/js/platform.js?publisherid=$username"},
      twitter:  {api: "https://userstream.twitter.com/1.1/$username.json"}
  }
  endpoints.each do |nname, options|
    SocialNet.seed do |i|
      i.name    = nname
      i.api_url = options[:api]
      # Add some interested users
    end
    SocialNet.all.each do |i|
      User.order("RANDOM()").first.social_nets << i
    end
  end

end