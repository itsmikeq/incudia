require 'rails_helper'

RSpec.describe BroadcastMessagesController, :type => :controller do
  let(:admin_user) { create(:user, admin: true) }
  let(:user) { create(:user) }
  let(:broadcast_message) { create(:broadcast_message) }
  context "Logged in user" do
    describe "GET /broadcast_messages" do
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

    describe "POST /broadcast_messages" do
      it 'only allows admin to post' do
        sign_in(admin_user)
        post :create, broadcast_message: {message: "Test", starts_at: Time.now, ends_at: Time.now + 1.hour, alert_type: :info}
        expect(response.status).to eq(302)
      end

    end
  end

end
