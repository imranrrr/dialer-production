require "application_system_test_case"

class DialsTest < ApplicationSystemTestCase
  setup do
    @dial = dials(:one)
  end

  test "visiting the index" do
    visit dials_url
    assert_selector "h1", text: "Dials"
  end

  test "creating a Dial" do
    visit dials_url
    click_on "New Dial"

    fill_in "Description", with: @dial.description
    fill_in "Sound url", with: @dial.sound_url
    click_on "Create Dial"

    assert_text "Dial was successfully created"
    click_on "Back"
  end

  test "updating a Dial" do
    visit dials_url
    click_on "Edit", match: :first

    fill_in "Description", with: @dial.description
    fill_in "Sound url", with: @dial.sound_url
    click_on "Update Dial"

    assert_text "Dial was successfully updated"
    click_on "Back"
  end

  test "destroying a Dial" do
    visit dials_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Dial was successfully destroyed"
  end
end
