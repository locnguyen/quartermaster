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
    expect { subject.create_asset }.to change { subject.assets.size }.from(0).to(1)
  end

  it "should create an asset with the argument hash" do
    serial = '1ab3'
    service = 'x2u87'
    asset = subject.create_asset({ serial_number: serial, service_tag: service })
    asset.serial_number.should == serial
    asset.service_tag.should == service
  end
end