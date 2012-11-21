ENV['RACK_ENV'] = 'test'

require_relative '../app/quartermaster'
require 'rubygems'
require 'dm-rspec2'
require 'rack/test'
require 'sinatra'
require 'rspec'
require 'database_cleaner'

app_dir = File.expand_path('../', __FILE__) # get absolute directory of app directory
Dir["#{app_dir}/app/models/**/*.rb"].each { |f| require f }

set :run, false
set :raise_errors, true
set :dump_errors, true
set :logging, true

RSpec.configure do |config|
  config.include DataMapper::Matchers
  config.include Rack::Test::Methods

  config.color_enabled = true
  config.tty = true

  config.before(:suite) do
  	DatabaseCleaner.strategy = :transaction
  	DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

def app
  Quartermaster
end
