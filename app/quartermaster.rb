require 'sinatra'
require 'sinatra/config_file'
require 'data_mapper'
require 'json'
require 'trinidad'

class Quartermaster < Sinatra::Base
  register Sinatra::ConfigFile
  config_file '../config/config.yml'

  ####################################################
  ###    Begin environment configuration
  ####################################################

  configure do
    enable :logging, :dump_errors, :raise_errors
    LOG = Logger.new('sinatra.log')
    LOG.datetime_format = '%Y-%m-%d %H:%M'
  end

  configure :development do
    LOG.level = Logger::DEBUG
    DataMapper::Logger.new(STDOUT, :debug)
    DataMapper::Logger.new('datamapper-sql.log', :debug)
    DataMapper::Model.raise_on_save_failure = true
    DataMapper.setup(:default, "sqlite:///db/#{settings.dbName}")
    DataMapper.auto_upgrade!
  end

  ####################################################
  ###    Begin API end points
  ####################################################

  get '/' do
    "Hello world!"
  end
end