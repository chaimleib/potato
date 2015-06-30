require 'rails_helper'

RSpec.describe "DueDates", type: :request do
  describe "GET /due_dates" do
    it "works! (now write some real specs)" do
      get due_dates_path
      expect(response).to have_http_status(200)
    end
  end
end
