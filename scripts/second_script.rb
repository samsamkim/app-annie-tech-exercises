require 'csv'
require 'active_record'
require 'time'

# Get start and end date from user
puts "Please input collection start date"
start_date = Date.parse(gets.chomp).strftime("%Y-%m-%d")

puts "Please input collection end date"
end_date = Date.parse(gets.chomp).strftime("%Y-%m-%d")

return puts 'Start date cannot be later than End date!' if start_date > end_date

puts "Please input the dimensions"
dimensions = gets.chomp

# Connect to postgres db through AciveRecord
ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'tech_exercises_development'
)

class Connection < ActiveRecord::Base

  # def grouped_by_dimensions(start_date, end_date, dimensions)
  #   self.where(date: start_date..end_date).group("date, #{dimensions}").select("date, sum(impressions) as impressions, sum(ad_revenue) as ad_revenue, #{dimensions}").map { |x| x.attributes.values.compact }
  # end

end

connections = Connection
  .where(date: start_date..end_date)
  .group("date, #{dimensions}")
  .select("date, sum(impressions) as impressions, sum(ad_revenue) as ad_revenue, #{dimensions}")
  .map { |x| x.attributes.values.compact }

file = "scripts/#{Time.now().to_i}.csv"

CSV.open( file, 'w' ) do |writer|
  headers = [dimensions.split(',').join(', '), 'impressions', 'ad_revenue', 'date']
  writer << headers
  connections.each do |s|
    writer << s
  end
end