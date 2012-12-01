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

  # def initialize
  #  @line_items = []
  # end

  def create_line_item
    line_item = LineItem.new({ reservation: self })
    line_items << line_item
    line_item
  end
end
