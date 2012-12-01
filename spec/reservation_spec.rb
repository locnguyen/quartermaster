require_relative 'spec_helper'

describe Reservation do

  it { should have_property :id }
  it { should have_property :name }
  it { should have_property :start_date }
  it { should have_property :end_date }

  it { should have_many :line_items }
  it { should have_many(:assets).through(:line_items) }

  context "managing line items" do
    subject { Reservation.gen }
    
    it "should create one without attributes" do
      subject.create_line_item.should be
    end

    it "should create one with the current reservation" do
      subject.id.should == subject.create_line_item.reservation.id
    end

    it "should accept attributes to create one"

    it "should create one and add to the reservation" do
      expect {
        subject.create_line_item
      }.to change { subject.line_items.size }.from(0).to(1)
    end

    it "should allow any to be added when the start date has not passed"

    it "should allow any to be deleted when the start date has not passed"

    it "should not allow any to be added after the start date has passed"

    it "should not allow any to be deleted afte rthe start date has passed"
  end

  context "finding based on dates" do
    before do
      #10.of { Reservation.gen(:closed_last_year) }
      #5.of { Reservation.gen(:closing_next_year) }
    end

    it "should find reservations that fall in between a start and end date"

    it "should find reservations are still open, or the end date has not passed"

    it "should find reservations that are closed, or the end date has passed"
  end
end
