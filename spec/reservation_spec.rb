require_relative 'spec_helper'

describe Reservation do

  it { should have_property :id }
  it { should have_property :name }
  it { should have_property :start_date }
  it { should have_property :end_date }

  it { should have_many :line_items }
  it { should have_many(:assets).through(:line_items) }

  describe "changing the reservation" do
    it "can check whether the reservation is editable" do
      subject.should respond_to :still_editable?
    end

    it "should not be editable if the start date has passed" do
      subject.start_date = Date.today - 1
      subject.still_editable?.should be_false
    end

    it "should be editable if the start date has not passed" do
      subject.start_date = Date.today + 1
      subject.still_editable?.should be_true
    end

    it "should take a date range for start and end dates" do
      subject.should respond_to(:set_date_range).with(2).arguments
    end

    it "should take a date range with ordered dates" do
      subject.set_date_range(Date.today, Date.today + 1)
      subject.start_date.should == Date.today
      subject.end_date.should == Date.today + 1
    end

    it "should not take a date range with unordered dates" do
      expect {
        subject.set_date_range(Date.today + 1, Date.today)
      }.to raise_error(ArgumentError)
    end

    context "after the start date has passed" do
      subject {
        Reservation.gen({ start_date: Date.today + 1, end_date: Date.today + 3 })
      }

      it "should not allow the line items to increase" do
        subject.start_date = Date.today - 1
        puts "start date = #{subject.start_date} #{subject.still_editable?}"
        expect {
          subject.create_line_item
        }.to_not change { subject.line_items.size } 
      end

      it "should not allow the line items to decrease" do
        line_item = subject.create_line_item
        line_item.id = 1
        subject.start_date = Date.today - 1
        expect {
          subject.remove_line_item 1
        }.to_not change { subject.line_items.size }
      end
    end
  end

  context "managing line items" do
    subject { 
      Reservation.gen({ start_date: Date.today + 1, end_date: Date.today + 10 })
    }
    
    it "can create line items" do
      subject.should respond_to :create_line_item
    end

    it "can remove a line item" do
      subject.should respond_to :remove_line_item
    end

    it "should create one without attributes" do
      subject.create_line_item.should be
    end

    it "should create one with the current reservation" do
      subject.id.should == subject.create_line_item.reservation.id
    end

    it "should accept attributes to create one" do
      subject.create_line_item({ notes: 'test notes' }).should be
    end

    it "should create one and add to the reservation" do
      expect {
        subject.create_line_item
      }.to change { subject.line_items.size }.from(0).to(1)
    end
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
