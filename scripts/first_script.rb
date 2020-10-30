require 'httparty'
require 'date'
require 'active_record'

# Ask user for start and end date
puts "Please input collection start date"
start_date = Date.parse(gets.chomp).strftime("%Y-%m-%d")

puts "Please input collection end date"
end_date = Date.parse(gets.chomp).strftime("%Y-%m-%d")

# Connecting to the Ascend API
base_uri = "https://api.libring.com/v2/reporting/get"
headers = {'Authorization' => 'Token DHDwhdFXfoGBYLPOZPvTTwJoS'}
query = {
  period: 'custom_date',
  start_date: start_date,
  end_date: end_date,
  group_by: 'connection,app,platform,country',
  data_type: 'adnetwork',
  allow_mock: 'true'
}
begin
  response = HTTParty.get(base_uri, headers: headers, query: query)
rescue HTTParty::Error => error
  puts error.inspect
rescue StandardError => error
  puts error.inspect
end

# Combining the connection data of all pages into one array
def combine_data(response)
  return response['connections'] if response['next_page_url'].empty?

  next_page_response = HTTParty.get(response['next_page_url'], headers: {'Authorization' => 'Token DHDwhdFXfoGBYLPOZPvTTwJoS'})
  response['connections'] + combine_data(next_page_response)
end

# Getting rid of unncessary attributes
total_connections = combine_data(response).map { |x| x.slice('country', 'app', 'platform', 'connection', 'impressions', 'date', 'ad_revenue') }

# Connect to database. Use ActiveRecord to insert total_connections to database
ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'tech_exercises_development'
)

class Connection < ActiveRecord::Base; end

# Insert total_connections to database
Connection.insert_all(total_connections)