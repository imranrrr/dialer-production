require "application_system_test_case"

class CdrsTest < ApplicationSystemTestCase
  setup do
    @cdr = cdrs(:one)
  end

  test "visiting the index" do
    visit cdrs_url
    assert_selector "h1", text: "Cdrs"
  end

  test "creating a Cdr" do
    visit cdrs_url
    click_on "New Cdr"

    click_on "Create Cdr"

    assert_text "Cdr was successfully created"
    click_on "Back"
  end

  test "updating a Cdr" do
    visit cdrs_url
    click_on "Edit", match: :first

    click_on "Update Cdr"

    assert_text "Cdr was successfully updated"
    click_on "Back"
  end

  test "destroying a Cdr" do
    visit cdrs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Cdr was successfully destroyed"
  end
end
