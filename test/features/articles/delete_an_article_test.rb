require "test_helper"
# Delete Articles
# As an editor I want to delete articles
# As an editor I should not be able to delete published articles
# As an author I should not be able to delete published articles
# As an author, I want to delete my unpublished articles
# As a site visitor, I should not be able to delete articles

feature "Delete An Article" do
  before(:all) do
    @text1 = "a[href='/articles/"
    @text2 = "'][data-method='delete']"
  end

  scenario "site visitor cannot see delete article button" do
    visit articles_path
    page.wont_have_link "Delete"
  end

  scenario "author can delete unpulished article" do
    sign_in(:author)
    article = articles(:test_article)
    visit articles_path
    # When the delete link is clicked
    find("#{@text1}#{article.id}#{@text2}").click
    page.text.must_include "Article was successfully destroyed"
    page.text.wont_include article.title
  end

  scenario "editor can delete unpublished article" do
    sign_in(:editor)
    article = articles(:test_article)
    visit articles_path
    # When the delete link is clicked
    find("#{@text1}#{article.id}#{@text2}").click
    page.text.must_include "Article was successfully destroyed"
    page.text.wont_include article.title
  end

  scenario "editor can not delete published article" do
    sign_in(:editor)
    article = articles(:pub_article)
    visit articles_path
    # The delete link is not seen
    page.has_no_css? "#{@text1}#{article.id}#{@text2}"
    page.text.wont_include "Article was successfully destroyed"
    page.text.must_include article.title
  end
end
