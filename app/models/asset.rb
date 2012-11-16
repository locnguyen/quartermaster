require 'data_mapper'

class Asset
  include DataMapper::Resource

  property :id, Serial
  property :serial_number, String, required: true
  property :acquire_date, Date, required: true
  property :retire_date, Date

  property :created_at , DateTime
  property :updated_at , DateTime

  belongs_to :product

  has n, :line_items
  has n, :reservations, :through => :line_items
end