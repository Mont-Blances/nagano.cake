require 'test_helper'

class Public::DeriveriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_deriveries_index_url
    assert_response :success
  end

  test "should get edit" do
    get public_deriveries_edit_url
    assert_response :success
  end

end
