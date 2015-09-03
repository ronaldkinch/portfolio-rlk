require "test_helper"

feature "Visit The Article Index" do
  scenario "show list of articles" do
    # Given that articles exist
    # When I visit articles list
    visit articles_path
    # Then existing articles are displayed
    page.text.must_include articles(:test_article).title
  end
end
