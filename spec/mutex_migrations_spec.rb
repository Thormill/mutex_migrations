RSpec.describe MutexMigrations do
  it "has a version number" do
    expect(MutexMigrations::VERSION).not_to be nil
  end

  describe "configuration" do
    it "enabled by default" do
      expect(MutexMigrations.new.enabled).to be_truthy
    end
  end
end
