require "test_helper"

feature "Authentication Sign Up" do
  scenario "valid signup information with account activation" do
    # Given a registration form
    visit root_path
    click_on "Sign Up"
    # When I register with info
    fill_in "Email", with: "new_user@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_on "Sign up"
    # Then I should be signed up
    # page.text.must_include "You have signed up successfully"
    # page.text.wont_include "prohibited this user from being saved"
  end

  scenario "invalid signup information fails" do
    # Given a registration form
    visit root_path
    click_on "Sign Up"
    # When I register with info
    fill_in "Email", with: "user@invalid"
    fill_in "Password", with: "foo"
    fill_in "Password confirmation", with: "bar"
    click_on "Sign up"
    # Then I should be signed up
    # page.text.must_include "prohibited this user from being saved"
    page.text.wont_include "You have signed up successfully"
  end

  scenario "sign in with twitter works" do
    skip
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:twitter,
                             uid: '12345',
                             info: { nickname: 'test_twitter_user' }
                            )
    visit root_path
    Capybara.current_session.driver.request.env['devise.mapping'] =
      Devise.mappings[:user]
    Capybara.current_session.driver.request.env['omniauth.auth'] =
      OmniAuth.config.mock_auth[:twitter]

    click_on "Sign in with Twitter"
    page.must_have_content "Logged in as test_twitter_user"
    # Courtesy of: https://gist.github.com/ivanoats/7071730
    # with help from https://github.com/intridea/omniauth/wiki/Integration-Testing
  end
end
