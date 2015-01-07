module Incudia
  class Logger < ::Logger

    def self.filename
      'generic.log'
    end

    def self.error(message)
      build.error(message)
    end

    def self.warn(message)
      build.warn(message)
    end

    def self.info(message)
      build.info(message)
    end

    def self.debug(message)
      build.debug(message)
    end

    def format_message(severity, timestamp, progname, msg)
      "#{timestamp.to_s(:long)}: #{msg}\n"
    end

    def self.read_latest
      path = Rails.root.join("log", filename)
      self.build unless File.exist?(path)
      tail_output, _ = Incudia::Popen.popen(%W(tail -n 2000 #{path}))
      tail_output.split("\n")
    end

    def self.read_latest_for(filename)
      path = Rails.root.join("log", filename)
      tail_output, _ = Incudia::Popen.popen(%W(tail -n 2000 #{path}))
      tail_output.split("\n")
    end

    def self.build
      new(Rails.root.join("log", filename))
    end
  end
end
