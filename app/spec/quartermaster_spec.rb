require_relative 'spec_helper'

describe "The Quartermaster API", :type => :api do
  it "should respond with OK at the root" do
    get '/'
    last_response.should be_ok
  end

  describe "/products" do
    it "GET should return all products"

    it "POST should create a product"
  end

  describe "/product/:id" do
    it "GET with :id should return the product"

    it "PUT with :id and request body should update a product"
  end
end