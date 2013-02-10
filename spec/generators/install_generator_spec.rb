require "spec_helper"

describe AfterParty::Generators::InstallGenerator do

require "generator_spec/test_case"

include GeneratorSpec::TestCase
destination File.expand_path("../../tmp", __FILE__)
arguments %w(active_record)

  context "with active_record" do
    before(:all) do
      prepare_destination
      run_generator
    end

    it "creates an initializer" do
      assert_file "config/initializers/after_party.rb", /require "lib\/after_party\/active_record"/
    end

    it "creates the migration file " do
      assert_migration "db/migrate/create_data_versions.rb", /def change/
    end
  end
end

describe AfterParty::Generators::InstallGenerator do

  require "generator_spec/test_case"

  include GeneratorSpec::TestCase
  destination File.expand_path("../../tmp", __FILE__)
  arguments %w(mongoid)

  context "with mongoid" do
    before(:all) do
      prepare_destination

      run_generator
    end

    it "creates an initializer for mongoid" do
      assert_file "config/initializers/after_party.rb", /require "lib\/after_party\/mongoid"/
    end

    it "creates no migration file " do
      assert_no_migration "db/migrate/create_data_versions.rb"
    end
  end
end