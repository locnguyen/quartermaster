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

  def create_line_item(attrs = {})
    if still_editable?
      line_item = LineItem.new({ reservation: self })
      line_item.attributes = attrs
      line_items << line_item
      line_item
    end
  end

  def remove_line_item(asset_id)
    if still_editable?
      line_items.delete_if { |item| item.id == asset_id }
    end
  end

  def still_editable?
    start_date > Date.today
  end

  def set_date_range(start_dt, end_dt)
    raise ArgumentError if start_dt > end_dt
    @start_date = start_dt
    @end_date = end_dt
  end

  def self.in_date_range(start_dt, end_dt)
    all(:start_date.lt => start_dt, :end_date.gt => end_dt)
  end

  def self.currently_open
    all(:end_date.gt => Date.today)
  end

  def self.closed
    all(:end_date.lt => Date.today)
  end

end
