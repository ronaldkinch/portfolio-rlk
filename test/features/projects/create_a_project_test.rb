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
end
