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
      puts "MUTEX LOCK"
      @mutex.lock
    rescue ThreadError
      false
    end

    def locked?
      puts "MUTEX LOCKED?"
      @mutex.locked?
    end

    def unlock
      puts "MUTEX UNLOCK"
      @mutex.unlock
    end

  end
end