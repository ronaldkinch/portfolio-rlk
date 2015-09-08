require "test_helper"

feature "first page" do
  scenario "has welcome" do
    visit root_path
    page.text.downcase.must_include "welcome"
    page.wont_have_content "Goodbye"
  end

  scenario "access from custom domain" do
    visit "http://www.error.com"
    # visit "http://www.ronaldkinch.com"
    page.text.downcase.must_include "welcome"
    page.wont_have_content "Goodbye"
  end
end
