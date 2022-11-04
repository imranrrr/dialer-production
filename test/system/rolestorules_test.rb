require "application_system_test_case"

class RolestorulesTest < ApplicationSystemTestCase
  setup do
    @rolestorule = rolestorules(:one)
  end

  test "visiting the index" do
    visit rolestorules_url
    assert_selector "h1", text: "Rolestorules"
  end

  test "creating a Rolestorule" do
    visit rolestorules_url
    click_on "New Rolestorule"

    fill_in "Role", with: @rolestorule.role_id
    fill_in "Rule", with: @rolestorule.rule_id
    click_on "Create Rolestorule"

    assert_text "Rolestorule was successfully created"
    click_on "Back"
  end

  test "updating a Rolestorule" do
    visit rolestorules_url
    click_on "Edit", match: :first

    fill_in "Role", with: @rolestorule.role_id
    fill_in "Rule", with: @rolestorule.rule_id
    click_on "Update Rolestorule"

    assert_text "Rolestorule was successfully updated"
    click_on "Back"
  end

  test "destroying a Rolestorule" do
    visit rolestorules_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Rolestorule was successfully destroyed"
  end
end
