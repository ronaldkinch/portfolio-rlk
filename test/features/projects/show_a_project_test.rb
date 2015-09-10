require "test_helper"

feature "Show A Project" do
  scenario "viewing a project" do
    # Given a project (loaded from fixtures)
    @project = projects(:portfolio)
    # When I visit /projects
    visit project_path(@project)
    # Then I should see only one project
    page.text.must_include "How meta"
    page.text.wont_include "Barnyard Cereal"
  end
end
