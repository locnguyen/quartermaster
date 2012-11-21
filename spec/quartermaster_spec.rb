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

  describe "/products" do
    context "GET" do
      it "should return all products"
    end

    context "POST" do
      it "should respond with 201 if successful" do
        product = { manufacturer: 'Olympus', model_name: 'OM-D EM-5' }
        post '/products', product.to_json
        last_response.status.should be == 201
      end

      it "should respond with the created product"
    end
  end

  describe "/product/:id" do
    context "GET" do
      it "should respond with a product with the ID"

      it "should respond with a 404 when the product doesn't exist"
    end

    context "PUT" do
      it "should update a product"

      it "should respond with a 404 when the product doesn't exit"
    end
  end
end