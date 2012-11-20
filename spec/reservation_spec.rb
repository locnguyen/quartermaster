require_relative 'spec_helper'

describe Reservation do
  subject { Reservation.new }

  it { should have_property :id }
  it { should have_property :name }
  it { should have_property :start_date }
  it { should have_property :end_date }

  it { should have_many :line_items }
  it { should have_many(:assets).through(:line_items) }

  it "should create a line item" do
    line_item = subject.create_line_item
    line_item.should be
  end

  it "should create a line item and add to the reservation" do
    before_count = subject.line_items.size
    subject.create_line_item
    after_count = subject.line_items.size
    after_count.should > before_count
  end
end