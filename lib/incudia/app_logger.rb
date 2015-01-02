module Incudia
  class AppLogger < Incudia::Logger
    def self.file_name_noext
      'application'
    end

    def format_message(severity, timestamp, progname, msg)
      "#{timestamp.to_s(:long)}: #{msg}\n"
    end
  end
end
