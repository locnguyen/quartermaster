require_relative 'spec_helper'

describe Asset do
  include ApiSpecHelper
  
  it { should have_property :id }
  it { should have_property :serial_number }
  it { should have_property :service_tag }
  it { should have_property :acquire_date }
  it { should have_property :retire_date }

  it { should belong_to :product }
  it { should have_many :line_items }
  it { should have_many(:reservations).through(:line_items) }

  it "must be created with a product", :broken => true do
    expect { Asset.new }.to raise_error(ArgumentError, "Cannot create an asset without a product")
  end
end