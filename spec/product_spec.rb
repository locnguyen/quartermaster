require_relative 'spec_helper'

describe Product do
  it { should have_property :id }
  it { should have_property :model_name }
  it { should have_property :manufacturer }

  it { should have_many :assets }

  it "should create an asset" do
    asset = subject.create_asset
    asset.should be
  end

  it "should create an asset and add to the product collection" do
    before_count = subject.assets.size
    subject.create_asset
    after_count = subject.assets.size
    before_count.should < after_count
  end

  it "should create an asset with the argument hash" do
    serial = '1ab3'
    service = 'x2u87'
    asset = subject.create_asset({ serial_number: serial, service_tag: service })
    asset.serial_number.should == serial
    asset.service_tag.should == service
  end
end