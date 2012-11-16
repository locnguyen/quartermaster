require_relative 'spec_helper'

describe "The Quartermaster API" do
  it "should respond with OK at the root" do
    get '/'
    last_response.should be_ok
  end
end