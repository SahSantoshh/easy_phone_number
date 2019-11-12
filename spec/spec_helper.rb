# frozen_string_literal: true

require 'bundler/setup'
require 'pry'

Dir[File.join(__dir__, '../lib', '*.rb')].each { |file| require_relative file }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end