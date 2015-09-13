require "test_helper"

feature "Delete An Article" do
  scenario "delete an existing article" do
    # Given a user is signed in
    sign_in

    # Given an existing article
    article = articles(:test_article)
    visit articles_path
    # When the delete link is clicked
    find("a[href='/articles/#{article.id}'][data-method='delete']").click
    # Then the article is deleted
    page.text.must_include "Article was successfully destroyed"
    page.text.wont_include article.title
  end
end
