require 'spec_helper'
require 'ostruct'

describe "The Assets API" do

  describe "/assets" do

    context "GET" do
      it "should respond with all assets" do
        5.of { Product.gen }
        get '/assets'
        json = JSON.parse(last_response.body)
        json.length.should be == 50
      end
    end

    context "POST" do

      let(:product) { Product.gen }

      subject {
        a = Asset.make
        a.product_id = product.id
        a
      }

      it "should respond with 201 if the asset was created" do
        post '/assets', subject.to_json
        last_response.status.should be == 201
      end

      it "should respond with an ID"

      it "should respond with a created_date"

      it "should respond with a Location URI header"
    end
  end

  describe "/asset/:id" do
    context "GET" do
      it "should respond with the asset"

      it "should respond with a 404 if the asset does not exist"

      it "should respond with a 400 if an ID parameter is not provided"
    end

    context "PUT" do
      it "should respond with a 200 if successful"

      it "should respond with the updated asset"

      it "should respond with a 400 if an ID parameter is not provided"

      it "should respond with a 404 if the asset doesn't exist"
    end

    context "DELETE" do
      it "should respond with 200 if successful"

      it "should respond with 404 if the asset is not found"

      it "should respond with 404 if called a second time after the first is successful"
    end
  end

  describe "/product/:id/assets" do
    context "POST" do
      it "should respond with 201 if the list of assets was added to the product"
    end

    context "GET" do
      it "should respond with all the assets for the product"
    end
  end
end