ENV['RACK_ENV'] = 'test'
root_dir = File.expand_path('../../', __FILE__) # get absolute path of root directory

require "#{root_dir}/app/quartermaster"
require 'rubygems'
require 'dm-rspec2'
require 'rack/test'
require 'sinatra'
require 'rspec'
require 'database_cleaner'
require 'dm-sweatshop'
require 'spec_fixtures'

set :run, false
set :raise_errors, false
set :dump_errors, true
set :logging, true

LOG = Logger.new("#{root_dir}/tmp/rspec.log")
LOG.datetime_format = '%Y-%m-%d %H:%M'

RSpec.configure do |config|
  config.include DataMapper::Matchers
  config.include Rack::Test::Methods

  config.filter_run_excluding :broken => true
  config.color_enabled = true
  config.tty = true

  config.before(:suite) do
  	DatabaseCleaner.strategy = :transaction
  	DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
    full_example_description = "#{self.class.description} #{@method_name}"
    # LOG.debug "\n\n#{full_example_description}\n#{'-' * (full_example_description.length)}"
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

def app
  Quartermaster
end
