require "rails_helper"

RSpec.describe DueDatesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/due_dates").to route_to("due_dates#index")
    end

    it "routes to #new" do
      expect(:get => "/due_dates/new").to route_to("due_dates#new")
    end

    it "routes to #show" do
      expect(:get => "/due_dates/1").to route_to("due_dates#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/due_dates/1/edit").to route_to("due_dates#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/due_dates").to route_to("due_dates#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/due_dates/1").to route_to("due_dates#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/due_dates/1").to route_to("due_dates#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/due_dates/1").to route_to("due_dates#destroy", :id => "1")
    end

  end
end
