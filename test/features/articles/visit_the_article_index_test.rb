require "test_helper"
# View Articles
# As an editor I want to see all articles regardless of published status
# As an author, I want to only see my own articles
# As a site visitor, (user) I want to read (view) articles
# As a site visitor, I want to only see published articles

feature "Visit The Article Index" do
  scenario "site visitor can see (only) published articles" do
    visit articles_path
    page.text.must_include articles(:pub_article).title
    page.text.wont_include articles(:test_article).title
  end

  scenario "author can only see own unpublished articles" do
    sign_in(:author)
    visit articles_path
    page.text.must_include articles(:test_article).title
    page.text.wont_include articles(:pub_article).title
    page.text.wont_include articles(:next_article).title
  end

  scenario "editor can see all articles" do
    sign_in(:editor)
    visit articles_path
    page.text.must_include articles(:test_article).title
    page.text.must_include articles(:pub_article).title
    page.text.must_include articles(:first_article).title
    page.text.must_include articles(:next_article).title
  end
end
