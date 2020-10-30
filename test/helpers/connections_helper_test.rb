require 'test_helper'

class ConnectionsHelperTest < ActionView::TestCase
  test "calculates cpm" do
    ad_revenue = 11.11
    impressions = 1111.0
    connection = Connection.new(impressions: 1111.0, ad_revenue: 11.11)

    assert_equal ( ad_revenue / (impressions.to_d / 1000.0) ), calculate_cpm(connection)
  end
end
