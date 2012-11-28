require 'data_mapper'

class Product
  include DataMapper::Resource

  property :id, Serial
  property :model_name, String, required: true
  property :manufacturer, String, required: true

  property :created_at , DateTime
  property :updated_at , DateTime

  has n, :assets, :constraint => :destroy

  def create_asset(a = {})
    asset = Asset.new
    asset.product = self
    asset.attributes = a unless a.nil?
    assets << asset
    asset
  end
end