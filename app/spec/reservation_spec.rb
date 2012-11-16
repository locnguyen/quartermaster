require_relative 'spec_helper'

describe Reservation do
  it { should have_property :id }
  it { should have_property :name }
  it { should have_property :start_date }
  it { should have_property :end_date }

  it { should have_many :line_items }
  it { should have_many(:assets).through(:line_items) }
end