require "test_helper"

feature "Authentication Sign In & Out" do
  scenario "sign in and out a valid user" do
    # Given a valid user (from fixtures)
    # When the user signs in
    sign_in
    # Then the sign in is successful
    page.text.must_include "Signed in successfully"
    # When the user signs out
    click_on "Sign Out"
    # Then the sign out is successful
    page.text.must_include "Signed out successfully"
    page.text.wont_include "There was a problem"
  end

  scenario "invalid sign in" do
    # Given a user atempting sign in
    visit new_user_session_path
    # When the user signs in with invalid email
    fill_in "Email", with: "user@invalid"
    fill_in "Password", with: "password"
    click_on "Log in"
    # Then the sign in is unsuccessful
    page.text.must_include "Invalid email or password"
    # When the user signs in with invalid password
    fill_in "Email", with: users(:user).email
    fill_in "Password", with: "invalid"
    click_on "Log in"
    # Then the sign in is unsuccessful
    page.text.must_include "Invalid email or password"
  end
end
