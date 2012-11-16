require 'data_mapper'

class Asset
  include DataMapper::Resource

  property :id, Serial
  property :serial_number, String
  property :acquire_date, Date
  property :retire_date, Date

  belongs_to :product

  has n, :line_items
  has n, :reservations, :through => :line_items
end