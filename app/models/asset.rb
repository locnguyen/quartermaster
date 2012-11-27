require 'data_mapper'

class Asset
  include DataMapper::Resource

  property :id, Serial
  property :serial_number, String, :required => true
  property :service_tag, String
  property :acquire_date, Date, :required => true
  property :retire_date, Date
  property :product_id, Integer

  property :created_at , DateTime
  property :updated_at , DateTime

  belongs_to :product

  has n, :line_items
  has n, :reservations, :through => :line_items

  #def initialize(attr = {})
    # raise(ArgumentError, "Cannot create an asset without a product", caller) if attr[:product].nil?

    #attr.each { |k, v| instance_variable_set("@#{k}", v) unless v.nil? }
  #end
end