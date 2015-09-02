require "minitest/autorun"
require "minitest/spec"
require "minitest/rails/capybara"

# Use Capybara and poltergeist with minitest.
class FeatureSpec < MiniTest::Spec
  require "capybara/poltergeist"
  include Capybara::DSL
  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, js_errors: false)
  end
  Capybara.default_driver = :poltergeist
  register_spec_type(/page$/, self)
end
