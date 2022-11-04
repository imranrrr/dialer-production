require "application_system_test_case"

class DialstogroupsTest < ApplicationSystemTestCase
  setup do
    @dialstogroup = dialstogroups(:one)
  end

  test "visiting the index" do
    visit dialstogroups_url
    assert_selector "h1", text: "Dialstogroups"
  end

  test "creating a Dialstogroup" do
    visit dialstogroups_url
    click_on "New Dialstogroup"

    fill_in "Dial", with: @dialstogroup.dial_id
    check "Dialed" if @dialstogroup.dialed
    fill_in "Group", with: @dialstogroup.group_id
    click_on "Create Dialstogroup"

    assert_text "Dialstogroup was successfully created"
    click_on "Back"
  end

  test "updating a Dialstogroup" do
    visit dialstogroups_url
    click_on "Edit", match: :first

    fill_in "Dial", with: @dialstogroup.dial_id
    check "Dialed" if @dialstogroup.dialed
    fill_in "Group", with: @dialstogroup.group_id
    click_on "Update Dialstogroup"

    assert_text "Dialstogroup was successfully updated"
    click_on "Back"
  end

  test "destroying a Dialstogroup" do
    visit dialstogroups_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Dialstogroup was successfully destroyed"
  end
end
