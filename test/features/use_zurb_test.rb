require "test_helper"

feature "UseZurb" do
  scenario "has Zurb class" do
    visit root_path
    page.html.must_include 'foundation-rails'
  end
end
