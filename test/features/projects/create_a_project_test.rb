require "test_helper"

feature "Create a Project" do
  scenario "submit data form to create a new project"do
    # Given a projects page create a new form
    visit projects_path
    click_on "New Project"
    fill_in "Name", with: "Code Fellows Portfolio"
    fill_in "Technologies used", with: "Rails, Ruby, HTML5, CSS3"
    # When I submit the form
    click_on "Create Project"
    # Then a new project should be created and displayed
    page.text.must_include "Project has been created"
    # assert page.has_css?("#notice"), "Expected a flash notice"
    page.status_code.must_equal 200
  end

  scenario "project has bad data" do
    # Given invalid project data is entered in a form
    visit new_project_path
    fill_in "Name", with: "A"
    # When the form is submitted with a short name and missing technologies_used field
    click_on "Create Project"
    # Then the form should be displayed again, with an error message
    current_path.must_match(/projects$/)
    page.text.must_include "Project could not be saved"
    page.text.must_include "Name is too short"
    page.text.must_include "Technologies used can't be blank"
  end
end
