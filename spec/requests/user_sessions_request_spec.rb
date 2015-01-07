require 'spec_helper'

RSpec.describe OmniauthCallbacksController, :type => :controller do
  describe "GET '/users/oauth/facebook'" do
    let(:user) { create(:facebook_omniauth) }
    before do
      puts user.inspect
      Incudia.config.omniauth.stub allow_single_sign_on: true
    end
    before(:each) do

      get "/users/oauth/facebook/callback"
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
    end

    it "should set user_id" do
      expect(session[:user_id]).to eq(User.last.id)
    end

    it "should redirect to root" do
      expect(response).to redirect_to root_path
    end
  end

  describe "GET '/auth/failure'" do

    it "should redirect to root" do
      get "/users/oauth/facebook/failure"
      expect(response).to redirect_to root_path
    end
  end
end
