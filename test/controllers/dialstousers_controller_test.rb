require "test_helper"

class DialstousersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dialstouser = dialstousers(:one)
  end

  test "should get index" do
    get dialstousers_url
    assert_response :success
  end

  test "should get new" do
    get new_dialstouser_url
    assert_response :success
  end

  test "should create dialstouser" do
    assert_difference('Dialstouser.count') do
      post dialstousers_url, params: { dialstouser: { dial_id: @dialstouser.dial_id, user_id: @dialstouser.user_id } }
    end

    assert_redirected_to dialstouser_url(Dialstouser.last)
  end

  test "should show dialstouser" do
    get dialstouser_url(@dialstouser)
    assert_response :success
  end

  test "should get edit" do
    get edit_dialstouser_url(@dialstouser)
    assert_response :success
  end

  test "should update dialstouser" do
    patch dialstouser_url(@dialstouser), params: { dialstouser: { dial_id: @dialstouser.dial_id, user_id: @dialstouser.user_id } }
    assert_redirected_to dialstouser_url(@dialstouser)
  end

  test "should destroy dialstouser" do
    assert_difference('Dialstouser.count', -1) do
      delete dialstouser_url(@dialstouser)
    end

    assert_redirected_to dialstousers_url
  end
end
