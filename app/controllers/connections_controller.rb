class ConnectionsController < ApplicationController

  def index
    checked_attributes_params =
      params[:checked_attributes].nil? ?
      ['country', 'app', 'platform', 'connection'] :
      params[:checked_attributes]
    checked_boxes = ',' + checked_attributes_params.join(',')

    @connections = Connection
      .group("date#{checked_boxes}")
      .select("date, sum(impressions) as impressions, sum(ad_revenue) as ad_revenue#{checked_boxes}")
      .as_json
      .map { |x| x.except!("id") }

    @headers = checked_attributes_params + ["impressions", "ad_revenue", "date"]

    respond_to do |format|
      format.html
      format.json
      format.js
    end
  end

end
