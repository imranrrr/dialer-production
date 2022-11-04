require "test_helper"

class RolestorulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rolestorule = rolestorules(:one)
  end

  test "should get index" do
    get rolestorules_url
    assert_response :success
  end

  test "should get new" do
    get new_rolestorule_url
    assert_response :success
  end

  test "should create rolestorule" do
    assert_difference('Rolestorule.count') do
      post rolestorules_url, params: { rolestorule: { role_id: @rolestorule.role_id, rule_id: @rolestorule.rule_id } }
    end

    assert_redirected_to rolestorule_url(Rolestorule.last)
  end

  test "should show rolestorule" do
    get rolestorule_url(@rolestorule)
    assert_response :success
  end

  test "should get edit" do
    get edit_rolestorule_url(@rolestorule)
    assert_response :success
  end

  test "should update rolestorule" do
    patch rolestorule_url(@rolestorule), params: { rolestorule: { role_id: @rolestorule.role_id, rule_id: @rolestorule.rule_id } }
    assert_redirected_to rolestorule_url(@rolestorule)
  end

  test "should destroy rolestorule" do
    assert_difference('Rolestorule.count', -1) do
      delete rolestorule_url(@rolestorule)
    end

    assert_redirected_to rolestorules_url
  end
end
