module ConnectionsHelper

  def calculate_cpm(connection)
    (connection['ad_revenue'] / (connection['impressions'].to_d / 1000.0))
  end

end
