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
    DataMapper::Model.raise_on_save_failure = false

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
    product = Product.create(data)

    if product.saved?
      content_type :json
      headers 'location' => "/product/#{product.id}"
      status 201
      product.to_json
    else
      LOG.debug product.errors.inspect
      halt 400
    end
  end

  get '/products' do
    if params[:model_name]
      products = Product.all(:model_name.like => params[:model_name])
    elsif params[:manufacturer]
      products = Product.all(:manufacturer.like => params[:manufacturer])
    else
      products = Product.all
    end

    products.to_json
  end

  get '/product/:id' do
    product = Product.get(params[:id])
    halt 404 if product.nil?
    product.to_json
  end

  put '/product/:id' do
    product = Product.get(params[:id])
    halt 404 if product.nil?
    data = OpenStruct.new(JSON.parse(request.body.read))
    product.attributes = data

    if product.update
      status 200
      product.to_json
    else
      halt 500
    end
  end

  delete '/product/:id' do
    product = Product.get(params[:id])
    halt 404 if product.nil?

    if product.destroy
      status 200
      'Product deleted'
    else
      halt 500
    end
  end

  get '/assets' do
    Asset.all.to_json
  end

  post '/assets' do
    data = JSON.parse(request.body.read)
    halt 404, 'Product not found' if Product.get(data['product_id']).nil?
    data['acquire_date'] = Date.parse(data['acquire_date'])
    asset = Asset.create(data)

    if asset.saved?
      status 201
      headers 'location' => "/asset/#{asset.id}"
      asset.to_json
    else
      LOG.debug asset.errors.inspect
      LOG.debug $!
      halt 400
    end
  end

  get '/asset/:id' do
    asset = Asset.get(params[:id])
    halt 404 if asset.nil?
    asset.to_json
  end

  put '/asset/:id' do
    asset = Asset.get(params[:id])
    halt 404 if asset.nil?
    asset.attributes = JSON.parse(request.body.read)

    if asset.save
      status 200
      asset.to_json
    else
      status 400
    end
  end

  delete '/asset/:id' do
    asset = Asset.get(params[:id])
    halt 404 if asset.nil?

    if asset.destroy
      status 200
      'Asset deleted'
    else
      status 500
    end
  end

  get '/product/:id/assets' do
    assets = Asset.all(:product_id => params[:id])
    assets.to_json
  end

  post '/product/:id/assets' do
    product = Product.get(params[:id])
    halt 404 if product.nil?
    assets = JSON.parse(request.body.read)

    assets.each do |a|
      product.create_asset a
    end

    if product.save
      status 201
      product.to_json
    else
      status 400
    end
  end
end
