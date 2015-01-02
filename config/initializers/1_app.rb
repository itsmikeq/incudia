module Incudia
  VERSION = File.read(Rails.root.join("VERSION")).strip
  REVISION = Incudia::Popen.popen(%W(git log --pretty=format:%h -n 1)).first.chomp

  def self.config
    Settings.incudia
  end
end

#
# Load all libs for threadsafety
#
Dir["#{Rails.root}/lib/**/*.rb"].each { |file| require file }
