RSpec.describe MutexMigrations do
  it "has a version number" do
    expect(MutexMigrations::VERSION).not_to be nil
  end

  describe "configuration" do
    it "enabled by default" do
      expect(MutexMigrations::Configuration.new.enabled).to be_truthy
    end

    it "changes settings" do
      MutexMigrations.configure do |config|
        config.enabled = false
      end

      expect(MutexMigrations.configuration.enabled).to be_falsy
    end
  end
end
