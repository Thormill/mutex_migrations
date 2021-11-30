module MutexMigrations
  class Symaphore
    include Singleton

    def initialize
      @mutex = Mutex.new
    end

    class << self
      def call
        return unless block_given?

        @mutex.synchronize do
          yield
        end
      end

      def lock
        @mutex.lock
      end

      def locked?
        @mutex.locked?
      end

      def unlock
        @mutex.unlock
      end
    end

  end
end