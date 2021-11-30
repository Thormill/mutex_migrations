require "mutex_migrations/version"
require "mutex_migrations/configuration"
require "mutex_migrations/symaphore"

module MutexMigrations
  class Error < StandardError; end

  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end

# ActiveRecord::Migrator.prepend(MutexMigrations::Migrator)