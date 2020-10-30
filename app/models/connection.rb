class Connection < ApplicationRecord
  attr_accessor :checked_attributes

  def calculate_cpm
    (ad_revenue / (impressions.to_d / 1000.0))
  end

end
