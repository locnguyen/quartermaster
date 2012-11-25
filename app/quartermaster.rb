require 'sinatra'
require 'sinatra/config_file'
require 'data_mapper'
require 'json'
require 'logger'
require 'ostruct'

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
  end

  configure :development do
    LOG.level = Logger::DEBUG
    DataMapper::Logger.new(STDOUT, :debug)
    DataMapper::Logger.new("#{Dir.pwd}/#{settings.tmpDir}/dm-dev.log", :debug)
    DataMapper::Model.raise_on_save_failure = true
   
    #DataMapper.setup(:default, {
    #  adapter: settings.adapter,
    #  username: settings.username,
    #  password: settings.password,
    #  database: settings.database
    #})

    DataMapper.setup(:default, 'postgres://developer:password@localhost/quartermaster-dev')
    DataMapper.finalize
    DataMapper.auto_upgrade!
  end

  configure :test do
    LOG.level = Logger::DEBUG
    DataMapper::Logger.new("#{Dir.pwd}/#{settings.tmpDir}/dm-test.log", :debug)
    DataMapper::Model.raise_on_save_failure = true
    DataMapper.setup(:default, 'postgres://developer:password@localhost/quartermaster-test')
    DataMapper.finalize
    DataMapper.auto_migrate!
  end

  ####################################################
  ###    Begin API end points
  ####################################################

  before do
    content_type :json
  end

  get '/' do
    "Hello world!"
  end

  post '/products' do
    data = JSON.parse(request.body.read)
    LOG.debug data
    product = Product.create(data)

    if product.saved?
      content_type :json
      status 201
      product.to_json
    else
      LOG.debug product.errors.inspect
      halt 500
    end
  end

  get '/products' do
    products = Product.all
    products.to_json
  end

  get '/product/:id' do
    product = Product.get(params[:id])

    if product.nil?
      halt 404
    end

    product.to_json
  end

  put '/product/:id' do
    product = Product.get(params[:id])

    if product.nil?
      halt 404
    end

    data = OpenStruct.new(JSON.parse(request.body.read))

    product.attributes = data

    if product.update
      status 200
    else
      halt 500
    end
  end
end
