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
      line_items.delete_if { |i| i.asset_id == asset_id }
    end
  end

  def still_editable?
    start_date > Date.today
  end
end
