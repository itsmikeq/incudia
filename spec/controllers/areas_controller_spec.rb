require 'rails_helper'

RSpec.describe AreasController, :type => :controller do
  let(:user) { create(:user) }
  let(:area) { create(:area) }
  context "Logged in user" do
    describe "GET /areas" do
      render_views
      it { should redirect_to(new_user_session_path) }

      it 'requires a logged in user' do
        get :index
        expect(response.status).to eq(302)
      end

      it 'renders the page with a logged in user' do
        sign_in(user)
        get :index
        expect(response).to be_success
      end
    end
  end

end
