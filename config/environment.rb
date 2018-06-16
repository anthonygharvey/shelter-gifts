# Load the Rails application.
require_relative 'application'
require 'open-uri'

configure :production do
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
end

# Initialize the Rails application.
Rails.application.initialize!
