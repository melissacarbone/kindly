# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Kindly::Application.initialize!
STDOUT.puts "RPM detected environment: #{NewRelic::LocalEnvironment.new}, RAILS_ENV: #{ENV['RAILS_ENV']}"

