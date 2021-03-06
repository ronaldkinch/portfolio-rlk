require "test_helper"

feature "Use Zurb" do
  scenario "has Zurb generated javascript" do
    visit root_path
    page.html.must_include 'modernizr'
  end

  scenario "has hero class" do
    # foundation.zurb.com/templates/portfolio-theme.html
    visit root_path
    page.html.must_include 'class="hero"'
  end
end
