require "rails_helper"

RSpec.describe PagesController, type: :controller do
  describe "GET #home" do
    it "returns http success" do
      get :home
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #dashboard" do
    context "unauthorized" do
      it "returns a 302" do
        get :dashboard
        expect(response).to have_http_status(302)
      end
    end
  end
end
