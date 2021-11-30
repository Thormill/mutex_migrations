require 'singleton'

module MutexMigrations
  class Semaphore
    include Singleton

    def initialize
      @mutex = Mutex.new
    end

    def call
      return unless block_given?

      @mutex.synchronize do
        yield
      end
    end

    def lock
      @mutex.try_lock
    end

    def locked?
      @mutex.locked?
    end

    def unlock
      @mutex.unlock
    end

  end
end