require_relative '../app/quartermaster'
require 'rubygems'
require 'dm-rspec2'
require 'rack/test'
require 'sinatra'

app_dir = File.expand_path('../', __FILE__) # get absolute directory of app directory
Dir["#{app_dir}/app/models/**/*.rb"].each { |f| require f }

set :environment, :test
set :run, false
set :raise_error, true
set :logging, false

RSpec.configure do |config|
  config.include DataMapper::Matchers
  config.include Rack::Test::Methods

  config.color_enabled = true
  config.tty = true
end

def app
  Quartermaster
end
