require "test_helper"

feature "Create An Article" do
  scenario "unauthorized visitor has limited article access" do
    # Given a visitor (not signed in)
    # When I visit the article index page
    visit articles_path
    # Then I do not see the new article link
    page.wont_have_link "New Article"

    # When I try to get new article form
    visit new_article_path
    # Then a denial message is displayed
    page.must_include "You need to sign in or sign up"
  end

  scenario "submit form data to create new article" do
    # Given a user is signed in
    sign_in(:author)

    # Given a completed new article form
    visit new_article_path
    fill_in "Title", with: "New Code Rails article"
    fill_in "Body", with: "This is how I learned to make web apps."
    # When I submit the form
    click_on "Create Article"
    # Then a new article should be created and displayed
    page.text.must_include "Article was successfully created"
    page.text.must_include "how I learned to make web apps"
    page.has_css? "#author"
    page.text.must_include users(:author).email
    page.text.must_include "Status: Unpublished"
  end
end
