require "spec_helper"

describe AfterParty::Generators::InstallGenerator do

require "generator_spec/test_case"

  include GeneratorSpec::TestCase
  destination File.expand_path("../../tmp", __FILE__)
  arguments %w(something)

  before(:all) do
    prepare_destination
    run_generator
  end

  it "creates an initializer" do
    assert_file "config/initializers/after_party.rb", "# Welcome to the party!"
  end

  it "creates the data version model" do
    assert_file "lib/after_party/data_version.rb", /class DataVersion < ActiveRecord::Base/
  end

  it "creates the data_version loader to" do
    assert_file "lib/after_party/data_version_file.rb", /class DataVersionFile/
  end

  it "creates the task runner rake file" do
    assert_file "lib/tasks/deploy_task_runner.rake", /task :run => :environment do/

  end

  it "creates the migration file " do
    assert_migration "db/migrate/create_data_versions.rb", /def change/
  end
end