require 'rails_helper'

RSpec.describe "ResourceUpdates", type: :request do
  describe "GET /resource_updates" do
    it "works!" do
      get resource_updates_path
      expect(response).to have_http_status(200)
    end
  end
end
