# frozen_string_literal: true

# class ConcurrentMigrationError < MigrationError # :nodoc:
#   DEFAULT_MESSAGE = "Cannot run migrations because another migration process is currently running."
#   RELEASE_LOCK_FAILED_MESSAGE = "Failed to release advisory lock"

#   def initialize(message = DEFAULT_MESSAGE)
#     super
#   end
# end

module MutexMigrations
  module Migrator # :nodoc:
    private

    def migrate
      if use_advisory_lock?
        if MutexMigrations.configuration.enabled
          with_file_lock { migrate_without_lock }
        else
          with_advisory_lock { migrate_without_lock }
        end
      else
        migrate_without_lock
      end
    end

    def with_file_lock
      Symaphore.call do |connection|
        load_migrated

        yield
      # ensure
      #   if got_lock && !connection.release_advisory_lock(lock_id)
      #     raise ConcurrentMigrationError.new(
      #       ConcurrentMigrationError::RELEASE_LOCK_FAILED_MESSAGE
      #     )
      #   end
      # end
    end

    # def with_advisory_lock_connection(&block)
    #   pool = ActiveRecord::ConnectionAdapters::ConnectionHandler.new.establish_connection(
    #     ActiveRecord::Base.connection_db_config
    #   )

    #   pool.with_connection(&block)
    # ensure
    #   pool&.disconnect!
    # end

    # MIGRATOR_SALT = 2053462845
    # def generate_migrator_advisory_lock_id
    #   db_name_hash = Zlib.crc32(Base.connection.current_database)
    #   MIGRATOR_SALT * db_name_hash
    # end
  end
end