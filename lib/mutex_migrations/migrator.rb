# frozen_string_literal: true
require "rails"

module MutexMigrations
  module Migrator # :nodoc:
    private

    def run
      if use_advisory_lock?
        if MutexMigrations.configuration.enabled
          with_mutex_lock { migrate_without_lock }
        else
          with_advisory_lock { run_without_lock }
        end
      else
        run_without_lock
      end
    end

    def migrate
      if use_advisory_lock?
        if MutexMigrations.configuration.enabled
          with_mutex_lock { migrate_without_lock }
        else
          with_advisory_lock { migrate_without_lock }
        end
      else
        migrate_without_lock
      end
    end

    def with_mutex_lock
      raise ConcurrentMigrationError unless Semaphore.lock

      with_advisory_lock_connection do |connection|
        load_migrated

        yield
      ensure
        unless Semaphore.unlock
          raise ConcurrentMigrationError.new(
            ConcurrentMigrationError::RELEASE_LOCK_FAILED_MESSAGE
          )
        end
      end
    end
  end
end
