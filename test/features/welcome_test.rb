require "test_helper"

describe "first page" do
  it "has welcome" do
    visit "/"
    page.text.downcase.must_include "welcome"
  end
end
