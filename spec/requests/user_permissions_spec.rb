require 'rails_helper'

RSpec.describe "UserPermissions", type: :request do
  describe "GET /user_permissions" do
    it "works! (now write some real specs)" do
      get user_permissions_path
      expect(response).to have_http_status(200)
    end
  end
end
