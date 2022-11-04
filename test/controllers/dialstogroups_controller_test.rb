require "test_helper"

class DialstogroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dialstogroup = dialstogroups(:one)
  end

  test "should get index" do
    get dialstogroups_url
    assert_response :success
  end

  test "should get new" do
    get new_dialstogroup_url
    assert_response :success
  end

  test "should create dialstogroup" do
    assert_difference('Dialstogroup.count') do
      post dialstogroups_url, params: { dialstogroup: { dial_id: @dialstogroup.dial_id, dialed: @dialstogroup.dialed, group_id: @dialstogroup.group_id } }
    end

    assert_redirected_to dialstogroup_url(Dialstogroup.last)
  end

  test "should show dialstogroup" do
    get dialstogroup_url(@dialstogroup)
    assert_response :success
  end

  test "should get edit" do
    get edit_dialstogroup_url(@dialstogroup)
    assert_response :success
  end

  test "should update dialstogroup" do
    patch dialstogroup_url(@dialstogroup), params: { dialstogroup: { dial_id: @dialstogroup.dial_id, dialed: @dialstogroup.dialed, group_id: @dialstogroup.group_id } }
    assert_redirected_to dialstogroup_url(@dialstogroup)
  end

  test "should destroy dialstogroup" do
    assert_difference('Dialstogroup.count', -1) do
      delete dialstogroup_url(@dialstogroup)
    end

    assert_redirected_to dialstogroups_url
  end
end
