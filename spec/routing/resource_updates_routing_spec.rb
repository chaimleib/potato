require "rails_helper"

RSpec.describe ResourceUpdatesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/resource_updates").to route_to("resource_updates#index")
    end

    it "routes to #new" do
      expect(:get => "/resource_updates/new").to route_to("resource_updates#new")
    end

    it "routes to #show" do
      expect(:get => "/resource_updates/1").to route_to("resource_updates#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/resource_updates/1/edit").to route_to("resource_updates#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/resource_updates").to route_to("resource_updates#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/resource_updates/1").to route_to("resource_updates#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/resource_updates/1").to route_to("resource_updates#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/resource_updates/1").to route_to("resource_updates#destroy", :id => "1")
    end

  end
end
