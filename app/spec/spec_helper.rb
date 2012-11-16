require_relative '../quartermaster'
require 'rubygems'
require 'dm-rspec2'
require 'rack/test'
require 'sinatra'

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