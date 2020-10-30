class ConnectionsController < ApplicationController

  def index
    start_date = set_date(Date.yesterday, params[:start_date])
    end_date = set_date(Date.today, params[:end_date])

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

  # def set_start_date
  #   return Date.yesterday if params[:start_date].blank?
  #   params[:start_date]
  # end

  # def set_end_date
  #   return Date.today if params[:end_date].blank?
  #   params[:end_date]
  # end

  def set_date(date, params_date)
    return date if params_date.blank?
    params_date
  end

end
