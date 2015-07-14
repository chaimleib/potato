require "rails_helper"

RSpec.describe UserPermissionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/user_permissions").to route_to("user_permissions#index")
    end

    it "routes to #new" do
      expect(:get => "/user_permissions/new").to route_to("user_permissions#new")
    end

    it "routes to #show" do
      expect(:get => "/user_permissions/1").to route_to("user_permissions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/user_permissions/1/edit").to route_to("user_permissions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/user_permissions").to route_to("user_permissions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/user_permissions/1").to route_to("user_permissions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/user_permissions/1").to route_to("user_permissions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/user_permissions/1").to route_to("user_permissions#destroy", :id => "1")
    end

  end
end
