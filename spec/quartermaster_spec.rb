require_relative 'spec_helper'
require 'sinatra'
require 'ostruct'

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
      it "should return all products" do
        50.of { Product.gen }

        get '/products'
        json = JSON.parse(last_response.body)
        json.length.should == 50
      end

      it "should return products matching manufacturer"
    end

    context "POST" do
      subject { Product.make }

      it "should respond with 201 if successful" do
        post '/products', subject.to_json
        last_response.status.should be == 201
      end

      it "should respond with an ID" do
        post '/products', subject.to_json
        LOG.debug last_response.body
        data = OpenStruct.new(JSON.parse(last_response.body))
        data.id.should be
      end

      it "should respond with a date for created_at" do
        post '/products', subject.to_json
        json = JSON.parse(last_response.body)
        json['created_at'].should be
      end
    end
  end

  describe "/product/:id" do
    subject { Product.gen }

    context "GET" do
      it "should respond a product with the ID" do
        get "/product/#{subject.id}"
        data = OpenStruct.new(JSON.parse(last_response.body))
        data.id.should be
      end

      it "should respond with a 404 when the product doesn't exist" do
        get '/product/999'
        last_response.status.should be == 404
      end
    end

    context "PUT should update a product" do
      it "should respond with 200 if successful" do
        subject.manufacturer = subject.manufacturer + rand(3).to_s
        put "/product/#{subject.id}", subject.to_json
        last_response.status.should be == 200
      end

      it "should respond with a 404 when the product doesn't exist" do
        put '/product/9999', subject.to_json
        last_response.status.should be == 404
      end
    end
  end
end