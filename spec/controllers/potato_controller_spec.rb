require 'rails_helper'

RSpec.describe PotatoController, type: :controller do

  describe "GET #overview" do
    it "returns http success" do
      get :overview
      expect(response).to have_http_status(:success)
    end
  end

end
