require "test_helper"

feature "Edit A Project" do
  scenario "submit updates to an existing project" do
    # Given an existing project
    visit edit_project_path(projects(:portfolio))
    # When I click edit and submit the changed data
    fill_in "Name", with: "Becoming a Web Developer"
    click_on "Update Project"
    # Then the content is saved and shown
    # page.text.must_include "Success"
    page.text.must_include "Project was successfully updated"
    page.text.must_include "Web Developer"
    page.text.wont_include "How meta"
  end

  scenario "incorrectly editing an existing project" do
    # Given an existing project
    visit edit_project_path(projects(:portfolio))

    # When I submit invalid changes
    fill_in "Name", with: "Err"
    click_on "Update Project"

    # Then the changes should not be saved, and I should get to try again
    page.text.must_include "prohibited"
    page.text.must_include "Name is too short"
  end
end
