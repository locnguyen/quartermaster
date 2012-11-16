class Reservation
  include DataMapper::Resource

  property :id, Serial
  property :name, String, required: true
  property :start_date, Date, required: true
  property :end_date, Date, required: true

  property :created_at , DateTime
  property :updated_at , DateTime

  has n, :line_items
  has n, :assets, :through => :line_items
end