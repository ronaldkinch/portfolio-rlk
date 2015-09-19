require "test_helper"

feature "Create An Article" do
  scenario "site visitor cannot visit new article page" do
    visit new_article_path
    page.must_have_content "You need to sign in or sign up"
  end

  scenario "site visitor cannot see new article button" do
    visit articles_path
    page.wont_have_link "New Article"
  end

  scenario "author can create new article" do
    sign_in(:author)
    visit new_article_path
    fill_in "Title", with: "New Code Rails article"
    fill_in "Body", with: "This is how I learned to make web apps."
    click_on "Create Article"
    page.text.must_include "Article was successfully created"
    page.text.must_include "how I learned to make web apps"
    page.has_css? "#author"
    page.text.must_include users(:author).email
    page.text.must_include "Status: Unpublished"
  end

  scenario "editor can create new article" do
    sign_in(:editor)
    visit new_article_path
    fill_in "Title", with: "New Code Rails article"
    fill_in "Body", with: "This is how I learned to make web apps."
    click_on "Create Article"
    page.text.must_include "Article was successfully created"
    page.text.must_include "how I learned to make web apps"
    page.has_css? "#author"
    page.text.must_include users(:editor).email
    page.text.must_include "Status: Unpublished"
  end
end
