require 'data_mapper'

class LineItem
  include DataMapper::Resource

  property :id, Serial

  property :created_at , DateTime
  property :updated_at , DateTime

  belongs_to :asset
  belongs_to :reservation

  def initialize(attr = {})
    raise(ArgumentError, 'Cannot create line item without a reservation', caller) if attr[:reservation].nil?

    attr.each { |k, v| instance_variable_set("@#{k}", v) unless v.nil? }
  end
end