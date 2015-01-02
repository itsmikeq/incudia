module Incudia
  class ProductionLogger < Incudia::Logger
    def self.file_name_noext
      'production'
    end
  end
end
