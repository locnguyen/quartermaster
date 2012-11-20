require_relative 'spec_helper'

describe "The Quartermaster API", :type => :api do
  it "should respond with OK at the root" do
    get '/'
    last_response.should be_ok
  end

  describe "/products" do

    describe "GET" do
      it "should return all products"
    end

    describe "POST" do
      it "should create a product with the request body"
    end
  end

  describe "/product/:id" do

    describe "GET" do
      it "should return a product"
    end

    describe "PUT" do
      it "should update a product with the request body"
    end
  end
end