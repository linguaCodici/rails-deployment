require 'rails_helper'

RSpec.describe "ApiDevelopments", type: :request do
  def parsed_body
    JSON.parse(response.body)
  end

  describe "RDBMS-backed" do
    before(:each) { Foo.delete_all }
    after(:each) { Foo.delete_all }

    it "create RDBMS-backed model" do
      object = Foo.create(:name => "test")
      expect(Foo.find(object.id).name).to eq("test")
    end

    it "expose RDBMS-backed API resource" do
      object = Foo.create(:name => "test")
      expect(foos_path).to eq("/api/foos")

      get foo_path(object.id)
      expect(response).to have_http_status(:ok)
      expect(parsed_body["name"]).to eq("test")
    end
  end

  describe "MongoDB-backed" do
    before(:each) { Bar.delete_all }
    after(:each) { Bar.delete_all }

    it "create MongoDB-backed model" do
      object = Bar.create(:name => "test")
      expect(Bar.find(object.id).name).to eq("test")
    end

    it "expose MongoDB-backed API resource" do
      object = Bar.create(:name => "test")
      expect(bars_path).to eq("/api/bars")

      get bar_path(object.id)
      expect(response).to have_http_status(:ok)
      expect(parsed_body["name"]).to eq("test")
      expect(parsed_body).to include("created_at")
      expect(parsed_body).to include("id"=>object.id.to_s)
    end
  end

  # describe "http" do
  #   before(:each) { Bar.delete_all }
  #   after(:each) { Bar.delete_all }
  #
  #   base_uri_1 = "http://localhost:3000/api/foos"
  #   base_uri_2 = "http://localhost:3000/api/bars"
  #
  #   it "get request should return ok" do
  #     (1..3).each.map {|i| Bar.create(:name => "test#{i}")}
  #     res = HTTParty.get(base_uri_1)
  #     expect(res.code).to eq(200)
  #     res = HTTParty.get(base_uri_2)
  #     expect(res.code).to eq(200)
  #   end
  #
  #   it "post request should return created" do
  #     res = HTTParty.post(base_uri_2, body: {bar: {name: "test2a"}})
  #     expect(res.code).to eq(201)
  #   end
  # end


end
