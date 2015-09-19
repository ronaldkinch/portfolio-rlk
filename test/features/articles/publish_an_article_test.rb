require "test_helper"

feature "Publish An Article" do
  scenario "authors can't publish" do
    sign_in(:author)
    visit new_article_path
    page.wont_have_field('published')
  end

  scenario "editors can publish" do
    sign_in(:editor)
    visit new_article_path
    page.must_have_field('Published')
    # When I submit the form
    fill_in "Title", with: articles(:test_article).title
    fill_in "Body", with: articles(:test_article).body
    check "Published"
    click_on "Create Article"
    # Then the published article should be shown
    page.text.must_include "Status: Published"
  end
end
