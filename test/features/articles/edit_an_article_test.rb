require "test_helper"

feature "Edit An Article" do
  scenario "site visitor cannot visit edit article page" do
    visit edit_article_path(articles(:test_article))
    page.must_have_content "You need to sign in or sign up"
  end

  scenario "site visitor cannot see edit article button" do
    visit articles_path
    page.wont_have_link "Edit"
  end

  scenario "author can submit updates to an existing article" do
    sign_in(:author)
    old_title = articles(:test_article).title
    visit edit_article_path(articles(:test_article))
    fill_in "Title", with: "Becoming a Web Developer"
    click_on "Update Article"
    page.text.must_include "Article was successfully updated"
    page.text.must_include "Becoming a Web Developer"
    page.text.wont_include old_title
  end

  scenario "editor can submit updates to an existing article" do
    sign_in(:editor)
    old_title = articles(:test_article).title
    visit edit_article_path(articles(:test_article))
    fill_in "Title", with: "Becoming a Web Developer"
    click_on "Update Article"
    page.text.must_include "Article was successfully updated"
    page.text.must_include "Becoming a Web Developer"
    page.text.wont_include old_title
  end
end
