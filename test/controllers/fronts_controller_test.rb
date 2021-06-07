require "test_helper"

class FrontsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get fronts_index_url
    assert_response :success
  end
end
