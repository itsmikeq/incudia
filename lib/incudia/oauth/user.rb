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
        raise_unauthorized_to_create unless ic_user

        if needs_blocking?
          ic_user.save!
          ic_user.block
        else
          ic_user.skip_confirmation! if ic_user.respond_to?(:skip_confirmation)
          ic_user.save!
        end

        log.info "(OAuth) saving user #{auth_hash.email} from login with extern_uid => #{auth_hash.uid}"
        log.info "User: #{ic_user.inspect}"
        ic_user
      rescue ActiveRecord::RecordInvalid => e
        log.info "(OAuth) Error saving user: #{ic_user.errors.full_messages}"
        return self, e.record.errors
      end

      def ic_user
        @user ||= find_for_oauth
      end

      protected

      def find_for_oauth(signed_in_resource = nil)

        # Get the identity and user if they exist
        identity = Identity.find_for_oauth(auth_hash)

        # If a signed_in_resource is provided it always overrides the existing user
        # to prevent the identity being locked with accidentally created accounts.
        # Note that this may leave zombie accounts (with no associated identity) which
        # can be cleaned up at a later date.
        user     = signed_in_resource ? signed_in_resource : identity.user

        # Create the user if needed
        if user.nil?

          # Get the existing user by email if the provider gives us a verified email.
          # If no verified email was provided we assign a temporary email and ask the
          # user to verify it on the next step via UsersController.finish_signup
          email = auth_hash.info.email
          user              =  if email
                                 model.where(:email => email).first || Email.where(:email => auth_hash.email).first.try(:user)
                               end

          # Create the user if it's a new registration
          if user.nil?
            user = build_new_user
            user.save!
          end
        end

        # Associate the identity with the user if needed
        if identity.user != user
          identity.user = user
          identity.save!
        end

        # Associate email to user to identity
        unless user.emails.pluck(:email).include?(auth_hash.email)
          user.emails.create(email: auth_hash.email)
        end
        user
      end

      def build_new_user
        model.new(user_attributes).tap do |user|
          user.skip_confirmation!
        end
      end

      def user_attributes
        _tmp_passwd = Devise.friendly_token[0, 20]
        {
            name:                  auth_hash.name,
            username:              (auth_hash.username || auth_hash.nickname || auth_hash.uid).gsub(/\s/,'').downcase,
            email:                 auth_hash.email,
            password:              auth_hash.password || _tmp_passwd,
            password_confirmation: auth_hash.password || _tmp_passwd,
        }
      end

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
