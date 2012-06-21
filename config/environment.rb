# Load the rails application
require File.expand_path('../application', __FILE__)

# Rails.env = 'production'    # Can be useful when Heroku blames you for a crash
# Rails.env = 'test'          # Can be useful when debugging creating tests

# Initialize the rails application
Bc::Application.initialize!
