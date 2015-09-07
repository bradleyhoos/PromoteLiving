# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require 'simplecov'
# require 'metric_fu/metrics/rcov/simplecov_formatter'
# SimpleCov.formatter = SimpleCov::Formatter::MetricFu
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'database_cleaner'
require 'ephemeral_response'
SimpleCov.start 'rails'
# SimpleCov.start

# Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.include FactoryGirl::Syntax::Methods
  config.include Devise::TestHelpers, type: :controller
  config.mock_with :rspec
  config.infer_base_class_for_anonymous_controllers = false
  config.raise_errors_for_deprecations!
  config.infer_spec_type_from_file_location!
end
FactoryGirl.definition_file_paths = [File.expand_path('../factories', __FILE__)]
# FactoryGirl.find_definitions
ActiveRecord::Migration.maintain_test_schema!

