module MutexMigrations
  class Symaphore
    include Singleton

    def initialize
      @mutex = Mutex.new
    end

    def self.call
      return unless block_given?

      @mutex.synchronize do
        yield
      end
    end
  end
end