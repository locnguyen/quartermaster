require 'spec_helper'
require 'api_spec_helper'

describe "The Assets API" do
  include ApiSpecHelper

  describe "/assets" do

    context "GET" do
      it "should respond with all assets" do
        5.of { Product.gen(:with_assets) }
        get '/assets'
        json = JSON.parse(last_response.body)
        json.length.should be == 50
      end
    end

    context "POST" do
      let(:product) { Product.gen }
      subject { Asset.make(:product_id => product.id) }

      it "should respond with 201 if the asset was created" do
        post '/assets', subject.to_json
        last_response.status.should be == 201
      end

      it "should respond with an ID" do
        post '/assets', subject.to_json
        data = json_to_struct last_response.body
        data.id.should be
      end

      it "should respond with a created_date" do
        post '/assets', subject.to_json
        data = json_to_struct last_response.body
        data.created_at.should be
      end

      it "should respond with a Location URI header" do
        post '/assets', subject.to_json
        data = json_to_struct last_response.body
        last_response.headers['location'].should be == "/asset/#{data.id}"
      end
    end
  end

  describe "/asset/:id" do

    context "GET" do
      subject { Asset.gen }

      it "should respond with the asset" do
        get "/asset/#{subject.id}"
        data = json_to_struct last_response.body
        data.id.should be
      end

      it "should respond with a 404 if the asset does not exist" do
        get '/asset/9999'
        last_response.status.should be == 404
      end
    end

    context "PUT" do
      subject { Asset.gen }

      it "should respond with a 200 if successful" do
        subject.serial_number = 'asdf' + rand(10).to_s
        put "/asset/#{subject.id}", subject.to_json
        last_response.status.should == 200
      end

      it "should respond with the updated asset" do
        before_serial_number = subject.serial_number
        subject.serial_number = 'asdf' + rand(10).to_s
        put "/asset/#{subject.id}", subject.to_json
        struct = json_to_struct last_response.body
        struct.serial_number.should_not be == before_serial_number
      end

      it "should respond with a 404 if the asset doesn't exist" do
        put '/asset/9999', subject.to_json
        last_response.status.should == 404
      end
    end

    context "DELETE" do
      subject { Asset.gen }

      it "should respond with 200 if successful" do
        delete "/asset/#{subject.id}"
        last_response.status.should == 200
      end

      it "should respond with 404 if the asset is not found" do
        delete '/asset/9999'
        last_response.status.should == 404
      end

      it "should respond with 404 if called a second time after the first is successful" do
        delete "/asset/#{subject.id}"    
        last_response.status.should == 200

        delete "/asset/#{subject.id}"    
        last_response.status.should == 404 
      end
    end
  end

  describe "/product/:id/assets" do

    context "POST" do
      let(:product) { Product.gen }
      subject { 3.of { Asset.make(:product_id => product.id) } }

      it "should respond with 201 if the list of assets was added to the product" do
        post "/product/#{product.id}/assets", subject.to_json
        last_response.status.should == 201
      end

      it "should increase the product's number of assets if successful" do

      end
    end

    context "GET" do
      subject { Product.gen(:with_assets) }

      it "should respond with all the assets for the product" do
        get "/product/#{subject.id}/assets"
        assets = JSON.parse(last_response.body)
        assets.length.should == subject.assets.length
      end
    end
  end
end