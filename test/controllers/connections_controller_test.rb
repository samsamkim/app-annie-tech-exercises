require 'test_helper'

class ConnectionsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "ajax request" do
    post connections_filter_path, xhr: true
  
    assert_response :success
    assert_equal "text/javascript", @response.media_type
  end
end
