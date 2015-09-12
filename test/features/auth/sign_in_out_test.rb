require "test_helper"

feature "Authentication Sign In & Out" do
  scenario "sign in and out a valid user" do
    # Given a valid user (from fixtures)
    # When the user signs in
    sign_in
    puts current_path, page.text
    # Then the sign in is successful
    # page.text.must_include "Signed in successfully"
    visit root_path
    puts current_path, page.text
    # When the user signs out
    # click_on "Sign Out"
    # Then the sign out is successful
    # page.text.must_include "Signed out successfully"
    page.text.wont_include "There was a problem"
  end
end
