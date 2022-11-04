require "test_helper"

class DialsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dial = dials(:one)
  end

  test "should get index" do
    get dials_url
    assert_response :success
  end

  test "should get new" do
    get new_dial_url
    assert_response :success
  end

  test "should create dial" do
    assert_difference('Dial.count') do
      post dials_url, params: { dial: { description: @dial.description, sound_url: @dial.sound_url } }
    end

    assert_redirected_to dial_url(Dial.last)
  end

  test "should show dial" do
    get dial_url(@dial)
    assert_response :success
  end

  test "should get edit" do
    get edit_dial_url(@dial)
    assert_response :success
  end

  test "should update dial" do
    patch dial_url(@dial), params: { dial: { description: @dial.description, sound_url: @dial.sound_url } }
    assert_redirected_to dial_url(@dial)
  end

  test "should destroy dial" do
    assert_difference('Dial.count', -1) do
      delete dial_url(@dial)
    end

    assert_redirected_to dials_url
  end
end
