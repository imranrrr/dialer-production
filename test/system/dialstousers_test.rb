require "application_system_test_case"

class DialstousersTest < ApplicationSystemTestCase
  setup do
    @dialstouser = dialstousers(:one)
  end

  test "visiting the index" do
    visit dialstousers_url
    assert_selector "h1", text: "Dialstousers"
  end

  test "creating a Dialstouser" do
    visit dialstousers_url
    click_on "New Dialstouser"

    fill_in "Dial", with: @dialstouser.dial_id
    fill_in "User", with: @dialstouser.user_id
    click_on "Create Dialstouser"

    assert_text "Dialstouser was successfully created"
    click_on "Back"
  end

  test "updating a Dialstouser" do
    visit dialstousers_url
    click_on "Edit", match: :first

    fill_in "Dial", with: @dialstouser.dial_id
    fill_in "User", with: @dialstouser.user_id
    click_on "Update Dialstouser"

    assert_text "Dialstouser was successfully updated"
    click_on "Back"
  end

  test "destroying a Dialstouser" do
    visit dialstousers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Dialstouser was successfully destroyed"
  end
end
