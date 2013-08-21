require "spec_helper"

describe VoteRecordsController do
  describe "routing" do

    it "routes to #index" do
      get("/vote_records").should route_to("vote_records#index")
    end

    it "routes to #new" do
      get("/vote_records/new").should route_to("vote_records#new")
    end

    it "routes to #show" do
      get("/vote_records/1").should route_to("vote_records#show", :id => "1")
    end

    it "routes to #edit" do
      get("/vote_records/1/edit").should route_to("vote_records#edit", :id => "1")
    end

    it "routes to #create" do
      post("/vote_records").should route_to("vote_records#create")
    end

    it "routes to #update" do
      put("/vote_records/1").should route_to("vote_records#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/vote_records/1").should route_to("vote_records#destroy", :id => "1")
    end

  end
end
