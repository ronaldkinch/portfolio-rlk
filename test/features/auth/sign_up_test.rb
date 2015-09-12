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
    page.text.must_include "You have signed up successfully"
    page.text.wont_include "prohibited this user from being saved"
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
    page.text.must_include "prohibited this user from being saved"
    page.text.wont_include "You have signed up successfully"
  end
end
