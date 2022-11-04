require "test_helper"

class CdrsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cdr = cdrs(:one)
  end

  test "should get index" do
    get cdrs_url
    assert_response :success
  end

  test "should get new" do
    get new_cdr_url
    assert_response :success
  end

  test "should create cdr" do
    assert_difference('Cdr.count') do
      post cdrs_url, params: { cdr: {  } }
    end

    assert_redirected_to cdr_url(Cdr.last)
  end

  test "should show cdr" do
    get cdr_url(@cdr)
    assert_response :success
  end

  test "should get edit" do
    get edit_cdr_url(@cdr)
    assert_response :success
  end

  test "should update cdr" do
    patch cdr_url(@cdr), params: { cdr: {  } }
    assert_redirected_to cdr_url(@cdr)
  end

  test "should destroy cdr" do
    assert_difference('Cdr.count', -1) do
      delete cdr_url(@cdr)
    end

    assert_redirected_to cdrs_url
  end
end
