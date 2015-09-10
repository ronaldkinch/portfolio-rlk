require "test_helper"

feature "Delete A Project" do
  scenario "delete an existing project" do
    # Given an existing project
    project = projects(:portfolio)
    visit projects_path
    # When the delete link is clicked
    find("a[href='/projects/#{project.id}'][data-method='delete']").click
    # Then the project is deleted
    page.text.must_include "Project was successfully destroyed"
    page.text.wont_include project.name
  end
end
