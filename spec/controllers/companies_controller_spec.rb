require 'rails_helper'

RSpec.describe CompaniesController, :type => :controller do
  let(:user) { create(:user) }
  let(:company) { create(:company) }
  describe "GET /companies" do
    context "not logged in" do
      render_views
      it { should redirect_to(new_user_session_path) }

      it 'requires a logged in user' do
        get :index
        expect(response.status).to eq(302)
      end

    end
    context "Logged in user" do
      it 'renders the page with a logged in user' do
        sign_in(user)
        get :index
        expect(response).to be_success
      end

      it 'allows users to create new companies' do
        sign_in(user)
        post :create, company: {name: Faker::Company.name, description: "Test company"}
        expect(response.status).to eq(302)
      end

    end
  end

end
