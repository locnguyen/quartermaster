require_relative 'spec_helper'

describe LineItem do
  subject { LineItem.new({ reservation: Reservation.new }) }

  it { should have_property :id }
  it { should have_property :notes }
  it { should belong_to :asset }
  it { should belong_to :reservation }

  it "must be created with a reservation", :broken => true do
    expect { LineItem.new }.to raise_error(ArgumentError, 'Cannot create line item without a reservation')
  end
end