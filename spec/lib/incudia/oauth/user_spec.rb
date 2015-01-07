require 'spec_helper'

describe Incudia::OAuth::User do
  let(:oauth_user) { Incudia::OAuth::User.new(auth_hash) }
  let(:ic_user) { oauth_user.ic_user }
  let(:uid) { 'my-uid' }
  let(:provider) { 'my-provider' }
  let(:auth_hash) { double(uid: uid, provider: provider, info: double(info_hash)) }
  let(:info_hash) do
    {
      nickname: 'john',
      name: 'John',
      email: 'john@mail.com'
    }
  end

  describe :persisted? do
    let!(:existing_user) { create(:user, extern_uid: 'my-uid', provider: 'my-provider') }

    before { Incudia.config.omniauth.stub allow_single_sign_on: true }
    before { Incudia.config.omniauth.stub block_auto_created_users: false }

    it "finds an existing user based on uid and provider (facebook)" do
      auth = double(info: double(name: 'John'), uid: 'my-uid', provider: 'my-provider')
      expect( oauth_user.persisted? ).to be_truthy
    end

    it "returns false if use is not found in database" do
      auth_hash.stub(uid: 'non-existing')
      expect( oauth_user.persisted? ).to be_falsey
    end
  end

  describe :save do
    let(:provider) { 'twitter' }

    describe 'signup' do
      context "with allow_single_sign_on enabled" do
        before { Incudia.config.omniauth.stub allow_single_sign_on: true }

        it "creates a user from Omniauth" do
          oauth_user.save

          expect(ic_user).to be_valid
          puts "Extern UID: #{ic_user.inspect}"
          expect(ic_user.extern_uid).to eql uid
          expect(ic_user.provider).to eql 'twitter'
        end
      end

    end

    describe 'blocking' do
      let(:provider) { 'twitter' }
      before { Incudia.config.omniauth.stub allow_single_sign_on: true }

      context 'signup' do
        context 'dont block on create' do
          before { Incudia.config.omniauth.stub block_auto_created_users: false }

          it do
            oauth_user.save
            ic_user.should be_valid
            ic_user.should_not be_blocked
          end
        end

        context 'block on create' do
          before { Incudia.config.omniauth.stub block_auto_created_users: true }

          it do
            oauth_user.save
            ic_user.should be_valid
            ic_user.should be_blocked
          end
        end
      end

      context 'sign-in' do
        before do
          oauth_user.save
          oauth_user.ic_user.activate
        end

        context 'dont block on create' do
          before { Incudia.config.omniauth.stub block_auto_created_users: false }

          it do
            oauth_user.save
            ic_user.should be_valid
            ic_user.should_not be_blocked
          end
        end

        context 'block on create' do
          before { Incudia.config.omniauth.stub block_auto_created_users: true }

          it do
            oauth_user.save
            ic_user.should be_valid
            ic_user.should_not be_blocked
          end
        end
      end
    end
  end
end
