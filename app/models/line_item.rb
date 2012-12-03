require 'data_mapper'

class LineItem
  include DataMapper::Resource

  property :id, Serial
  property :notes, String

  property :created_at , DateTime
  property :updated_at , DateTime

  belongs_to :asset
  belongs_to :reservation
end