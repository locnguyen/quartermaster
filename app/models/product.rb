require 'data_mapper'

class Product
  include DataMapper::Resource

  property :id, Serial
  property :model_name, String
  property :manufacturer, String

  has n, :assets
end