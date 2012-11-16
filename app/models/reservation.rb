class Reservation
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :start_date, Date
  property :end_date, Date

  has n, :line_items
  has n, :assets, :through => :line_items
end