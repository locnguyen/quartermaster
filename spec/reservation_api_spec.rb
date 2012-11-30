require 'spec_helper'
require 'api_spec_helper'

describe "The Reservations API" do
  include ApiSpecHelper

  before do
    header 'HTTP_ACCEPT', 'application/json'
    header 'CONTENT_TYPE', 'application/json'
  end

  describe "/reservations" do
    context "GET" do
      it "should respond with all reservations"

      it "should respond with reservations in a date range"

      it "should respond with reservations that are open"

      it "should respond with reservations that are closed"
    end
  end
end
