module MutexMigrations
  class Configuration
    attr_accessor :enabled

    def initialize
      @enabled = true
    end
  end
end