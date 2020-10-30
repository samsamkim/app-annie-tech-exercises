require 'csv'
require 'active_record'
require 'time'

# Get start and end date from user
puts "Please input collection start date"
start_date = Date.parse(gets.chomp).strftime("%Y-%m-%d")

puts "Please input collection end date"
end_date = Date.parse(gets.chomp).strftime("%Y-%m-%d")

return puts 'Start date cannot be later than End date!' if start_date > end_date

puts "Please input the dimensions in comma separated format"
dimensions = gets.chomp
qry_dimensions = dimensions.present? ? ',' + dimensions : ''

# Connect to postgres db through AciveRecord
ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'tech_exercises_development'
)
class Connection < ActiveRecord::Base; end

grouping_qry = "date" + qry_dimensions
selecting_qry = "date, sum(impressions) as impressions, sum(ad_revenue) as ad_revenue" + qry_dimensions

connections = Connection
  .where(date: start_date..end_date)
  .group(grouping_qry)
  .select(selecting_qry)
  .map { |x| x.attributes.values.compact }

file = "scripts/#{Time.now().to_i}.csv"

CSV.open( file, 'w' ) do |writer|
  dimension_array = dimensions.present? ? dimensions.split(',') : []
  headers = dimension_array + ['impressions', 'ad_revenue', 'date']
  writer << headers
  connections.each do |s|
    writer << s
  end
end