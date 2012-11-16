require 'sinatra'
require 'sinatra/config_file'
require 'data_mapper'
require 'json'
require 'logger'

current_folder = File.expand_path('../', __FILE__) # get absolute directory
Dir["#{current_folder}/models/**/*.rb"].each { |f| require f }

class Quartermaster < Sinatra::Base
  register Sinatra::ConfigFile
  config_file '../config/config.yml'

  ####################################################
  ###    Begin environment configuration
  ####################################################

  configure do
    enable :logging, :dump_errors, :raise_errors
    LOG = Logger.new("#{Dir.pwd}/#{settings.tmpDir}/sinatra.log")
    LOG.datetime_format = '%Y-%m-%d %H:%M'
    DataMapper::Logger.new("#{Dir.pwd}/#{settings.tmpDir}/datamapper-sql.log", :debug)
  end

  configure :development do
    LOG.level = Logger::DEBUG
    DataMapper::Logger.new(STDOUT, :debug)
    DataMapper::Model.raise_on_save_failure = true
    DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/db/development.db")
    DataMapper.finalize
    DataMapper.auto_upgrade!
  end

  ####################################################
  ###    Begin API end points
  ####################################################

  get '/' do
    "Hello world!"
  end
end
