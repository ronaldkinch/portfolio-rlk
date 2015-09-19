ENV["RAILS_ENV"] = "test"
Rails.env = "test"
require "simplecov"
SimpleCov.start "rails" # Must be before any required application code

require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
require "minitest/rails/capybara" # To add Capybara feature tests
require "minitest/pride" # For awesome colorful output

class ActiveSupport::TestCase
  fixtures :all # Setup all fixtures in test/fixtures/*.yml
  # Add more helper methods to be used by all tests here...
  def sign_in(role = :editor)
    # Sign in authenticated user
    visit new_user_session_path
    fill_in "Email", with: users(role).email
    fill_in "Password", with: "password"
    click_on "Log in"
  end
end

system 'rubocop'

# class CapybaraTestCase < MiniTest::Spec
#   include Capybara::DSL
#   register_spec_type(/page$/, self)
# end
