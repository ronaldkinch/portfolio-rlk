require "test_helper"

feature "Edit An Article" do
  scenario "submit updates to an existing article" do
    # Given a user is signed in
    sign_in(:author)

    # Given an existing article
    visit article_path(articles(:test_article))
    old_title = articles(:test_article).title
    # When I click edit and submit the changed data
    click_on "Edit"
    fill_in "Title", with: "Becoming a Web Developer"
    click_on "Update Article"
    # Then the content is updated
    page.text.must_include "Article was successfully updated"
    page.text.must_include "Becoming a Web Developer"
    page.text.wont_include old_title
  end
end
