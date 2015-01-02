# OAuth extension for User model
#
# * Find Incudia user based on omniauth uid and provider
# * Create new user from omniauth data
#
module Incudia
  module OAuth
    class User
      attr_accessor :auth_hash, :ic_user

      def initialize(auth_hash)
        self.auth_hash = auth_hash
      end

      def persisted?
        ic_user.try(:persisted?)
      end

      def new?
        !persisted?
      end

      def valid?
        ic_user.try(:valid?)
      end

      def save
        unauthorized_to_create unless ic_user

        if needs_blocking?
          ic_user.save!
          ic_user.block
        else
          ic_user.save!
        end

        log.info "(OAuth) saving user #{auth_hash.email} from login with extern_uid => #{auth_hash.uid}"
        ic_user
      rescue ActiveRecord::RecordInvalid => e
        log.info "(OAuth) Error saving user: #{ic_user.errors.full_messages}"
        return self, e.record.errors
      end

      def ic_user
        @user ||= find_by_uid_and_provider

        if signup_enabled?
          @user ||= build_new_user
        end

        @user
      end

      protected

      def needs_blocking?
        new? && block_after_signup?
      end

      def signup_enabled?
        Incudia.config.omniauth.allow_single_sign_on
      end

      def block_after_signup?
        Incudia.config.omniauth.block_auto_created_users
      end

      def auth_hash=(auth_hash)
        @auth_hash = AuthHash.new(auth_hash)
      end

      def find_by_uid_and_provider
        model.where(provider: auth_hash.provider, extern_uid: auth_hash.uid).last
      end

      def build_new_user
        model.new(user_attributes).tap do |user|
          user.skip_confirmation!
        end
      end

      def user_attributes
        {
            extern_uid:            auth_hash.uid,
            provider:              auth_hash.provider,
            name:                  auth_hash.name,
            username:              auth_hash.username,
            email:                 auth_hash.email,
            password:              auth_hash.password,
            password_confirmation: auth_hash.password,
        }
      end

      def log
        Incudia::AppLogger
      end

      def model
        ::User
      end

      def raise_unauthorized_to_create
        raise StandardError.new("Unauthorized to create user, signup disabled for #{auth_hash.provider}")
      end
    end
  end
end
