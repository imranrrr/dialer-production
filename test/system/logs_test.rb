require "application_system_test_case"

class LogsTest < ApplicationSystemTestCase
  setup do
    @log = logs(:one)
  end

  test "visiting the index" do
    visit logs_url
    assert_selector "h1", text: "Logs"
  end

  test "creating a Log" do
    visit logs_url
    click_on "New Log"

    fill_in "Exception class", with: @log.exception_class
    fill_in "Exception message", with: @log.exception_message
    fill_in "Group", with: @log.group_id
    fill_in "Http host", with: @log.http_host
    fill_in "Ip", with: @log.ip
    fill_in "Path", with: @log.path
    fill_in "Rank", with: @log.rank
    fill_in "Request method", with: @log.request_method
    fill_in "Role", with: @log.role_id
    fill_in "Status", with: @log.status
    fill_in "Time spent", with: @log.time_spent
    fill_in "Url", with: @log.url
    fill_in "User agent", with: @log.user_agent
    fill_in "User", with: @log.user_id
    fill_in "User inspect", with: @log.user_inspect
    click_on "Create Log"

    assert_text "Log was successfully created"
    click_on "Back"
  end

  test "updating a Log" do
    visit logs_url
    click_on "Edit", match: :first

    fill_in "Exception class", with: @log.exception_class
    fill_in "Exception message", with: @log.exception_message
    fill_in "Group", with: @log.group_id
    fill_in "Http host", with: @log.http_host
    fill_in "Ip", with: @log.ip
    fill_in "Path", with: @log.path
    fill_in "Rank", with: @log.rank
    fill_in "Request method", with: @log.request_method
    fill_in "Role", with: @log.role_id
    fill_in "Status", with: @log.status
    fill_in "Time spent", with: @log.time_spent
    fill_in "Url", with: @log.url
    fill_in "User agent", with: @log.user_agent
    fill_in "User", with: @log.user_id
    fill_in "User inspect", with: @log.user_inspect
    click_on "Update Log"

    assert_text "Log was successfully updated"
    click_on "Back"
  end

  test "destroying a Log" do
    visit logs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Log was successfully destroyed"
  end
end
