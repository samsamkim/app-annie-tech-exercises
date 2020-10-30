class ConnectionsController < ApplicationController

  def index
    start_date = params[:start_date]
    end_date = params[:end_date]

    checked_attributes =
      params[:checked_attributes].nil? ?
      'country,app,platform,connection' :
      params[:checked_attributes]

    checked_boxes = checked_attributes + (checked_attributes.blank? ? '' : ',')
    @headers = checked_attributes.split(',') + ["impressions", "ad_revenue", "date"]

    @connections = Connection.grouped_and_filtered(start_date, end_date, checked_boxes)
    respond_to do |format|
      format.html
      format.js
    end
  end

end
