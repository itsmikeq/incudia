module Incudia
  class OAuthLogger < ::Incudia::Logger
    def self.filename
      'oauth.log'
    end
  end
end
