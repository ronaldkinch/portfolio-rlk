require "test_helper"

feature "Publish An Article" do
  scenario "authors can't publish" do
    # Given an author's account
    sign_in(:author)
    # When I visit the new page
    visit new_article_path
    # Then there is no checkbox for published
    page.wont_have_field('article[published]')
  end

  scenario "editors can publish" do
    # Given an editor's account
    sign_in(:editor)
    # When I visit the new page
    visit new_article_path
    # Then there is a checkbox for published
    page.must_have_field('article[published]')

    # When I submit the form
    fill_in "Title", with: articles(:test_article).title
    fill_in "Body", with: articles(:test_article).body
    check "Published"
    click_on "Create Article"
    # Then the published article should be shown
    page.text.must_include "Status: Published"
  end
end
