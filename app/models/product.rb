require 'data_mapper'

class Product
  include DataMapper::Resource

  property :id, Serial
  property :model_name, String, required: true
  property :manufacturer, String, required: true

  property :created_at , DateTime
  property :updated_at , DateTime

  has n, :assets
end