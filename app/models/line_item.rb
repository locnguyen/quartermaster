class LineItem
  include DataMapper::Resource

  property :id, Serial

  belongs_to :asset
  belongs_to :reservation
end