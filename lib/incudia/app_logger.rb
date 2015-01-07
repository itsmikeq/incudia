module Incudia
  class AppLogger < ::Incudia::Logger
    def self.filename
      'application.log'
    end

  end
end
