require 'spec_helper'
require 'ostruct'

describe "The Products API" do

  before do
    header 'HTTP_ACCEPT', 'application/json'
    header 'CONTENT_TYPE', 'application/json'
  end

  describe "/products" do
    context "GET" do
      it "should respond with all products" do
        50.of { Product.gen }

        get '/products'
        results = JSON.parse(last_response.body)
        results.length.should == 50
      end

      it "should respond with products matching manufacturer" do
        10.of { Product.gen(:panasonic) }

        get '/products?manufacturer=Panasonic'
        results = JSON.parse(last_response.body)
        results.length.should == 10
      end

      it "should respond with products matching model name" do
        Product.gen(:panasonic_gh3)

        get '/products?model_name=GH3'
        results = JSON.parse(last_response.body)
        results[0]['model_name'].should be == 'GH3'
      end
    end

    context "POST" do
      subject { Product.make }

      it "should respond with 201 if successful" do
        post '/products', subject.to_json
        last_response.status.should be == 201
      end

      it "should respond with an ID" do
        post '/products', subject.to_json
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
      it "should respond with a product with the ID" do
        get "/product/#{subject.id}"
        data = OpenStruct.new(JSON.parse(last_response.body))
        data.id.should be
      end

      it "should respond with a 404 when the product doesn't exist" do
        get '/product/999'
        last_response.status.should be == 404
      end
    end

    context "PUT" do
      it "should respond with 200 if successful" do
        before_manufacturer = subject.manufacturer
        subject.manufacturer = before_manufacturer + rand(3).to_s
        put "/product/#{subject.id}", subject.to_json
        last_response.status.should be == 200
      end

      it "should respond with the updated product" do
        before_manufacturer = subject.manufacturer
        subject.manufacturer = before_manufacturer + rand(3).to_s
        put "/product/#{subject.id}", subject.to_json
        data = OpenStruct.new(JSON.parse(last_response.body))
        data.manufacturer.should be == before_manufacturer
      end

      it "should respond with a 404 when the product doesn't exist" do
        put '/product/9999', subject.to_json
        last_response.status.should be == 404
      end
    end

    context "DELETE" do
      it "should respond with 200 if successful" do
        delete "/product/#{subject.id}"
        last_response.status.should be == 200
      end

      it "should respond with 404 if called a second time since the first should have deleted" do
        delete "/product/#{subject.id}"
        last_response.status.should be == 200

        delete "/product/#{subject.id}"
        last_response.status.should be == 404
      end

      it "should respond with 404 if the product does not exist" do
        delete '/product/9999'
        last_response.status.should be == 404
      end
    end
  end
end