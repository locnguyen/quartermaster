require_relative 'spec_helper'
require 'sinatra'

describe "The Quartermaster API", :type => :api do

  before do
    header 'HTTP_ACCEPT', 'application/json'
    header 'CONTENT_TYPE', 'application/json'
  end

  it "should respond with OK at the root" do
    get '/'
    last_response.should be_ok
  end
end