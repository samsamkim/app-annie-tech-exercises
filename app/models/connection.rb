class Connection < ApplicationRecord

  def self.grouped_and_filtered(start_date, end_date, checked_boxes)
    self
      .where(date: start_date..end_date)
      .group("#{checked_boxes}date")
      .select("#{checked_boxes}date, sum(impressions) as impressions, sum(ad_revenue) as ad_revenue")
      .as_json
      .map { |x| x.except!("id") }
  end

end
