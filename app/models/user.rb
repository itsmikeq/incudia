# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  admin                  :boolean          default("false"), not null
#  locked                 :boolean          default("false"), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime
#  updated_at             :datetime
#  authentication_token   :string
#  provider               :string
#  extern_uid             :string
#  username               :string
#  name                   :string
#  visibility_level       :integer
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  include TokenAuthenticatable
  include Incudia::VisibilityLevel

  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX  = /\Achange@me/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable

  has_many :social_nets_users, dependent: :destroy
  has_many :social_nets, through: :social_nets_users
  has_many :areas_users, dependent: :destroy
  has_many :areas, through: :areas_users
  has_many :interests_users
  has_many :interests, through: :interests_users
  has_many :identities, dependent: :destroy
  accepts_nested_attributes_for :identities, reject_if: lambda { |attributes| attributes['kind'].blank? }
  # has_many :memberships, ->(user) {where membership: { member_id: user.id}}
  # has_many :owned_memberships, -> { where membership: { access_level: Incudia::Access::OWNER } }, through: :memberships, source: :membership

  default_value_for :admin, false

  # Validations
  validates :username, presence: true, uniqueness: {case_sensitive: false},
            exclusion:           {in: Incudia::Blacklist.path},
            format:              {with:    Incudia::Regex.username_regex,
                                  message: Incudia::Regex.username_regex_message}

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  # :email
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  scope :admins, -> { where(admin: true) }

  # Virtual attribute for authenticating by either username or email
  attr_accessor :login
  # Pagination
  paginates_per 100


  # Class methods
  class << self

    def find_for_oauth(auth, signed_in_resource = nil)

      # Get the identity and user if they exist
      identity = Identity.find_for_oauth(auth)

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
        email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
        email             = auth.info.email if email_is_verified
        user              = User.where(:email => email).first if email

        # Create the user if it's a new registration
        if user.nil?
          user = User.new(
              name:     auth.extra.raw_info.name,
              #username: auth.info.nickname || auth.uid,
              email:    email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
              password: Devise.friendly_token[0, 20]
          )
          user.skip_confirmation!
          user.save!
        end
      end

      # Associate the identity with the user if needed
      if identity.user != user
        identity.user = user
        identity.save!
      end
      user
    end

    # Devise method overridden to allow sign in with email or username
    def find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where(["lower(username) = :value OR lower(email) = :value", {value: login.downcase}]).first
      else
        where(conditions).first
      end
    end

    def search(query)
      where("lower(name) LIKE :query OR lower(email) LIKE :query OR lower(username) LIKE :query", query: "%#{query.downcase}%")
    end

    def by_login(login)
      where('lower(username) = :value OR lower(email) = :value',
            value: login.to_s.downcase).first
    end

    def by_username_or_id(name_or_id)
      where('users.username = ? OR users.id = ?', name_or_id.to_s, name_or_id.to_i).first
    end

    def build_user(attrs = {})
      User.new(attrs)
    end

    def paged(page_number)
      order(admin: :desc, email: :asc).page page_number
    end

    def search_and_order(search, page_number)
      if search
        where("email LIKE ?", "%#{search.downcase}%").order(
            admin: :desc, email: :asc
        ).page page_number
      else
        order(admin: :desc, email: :asc).page page_number
      end
    end

    def last_signups(count)
      order(created_at: :desc).limit(count).select("id", "email", "created_at")
    end

    def last_signins(count)
      order(last_sign_in_at:
                :desc).limit(count).select("id", "email", "last_sign_in_at")
    end

    def users_count
      where("admin = ? AND locked = ?", false, false).count
    end
  end

  # Instance methods

  def memberships
    Membership.where(member_id: id, of_type: "User")
  end

  def namespace_uniq
    namespace_name = self.username
    if Namespace.find_by(path: namespace_name)
      self.errors.add :username, "already exists"
    end
  end

  def unique_email
    self.errors.add(:email, 'has already been taken') if Email.exists?(email: self.email)
  end

  def with_defaults
    User.defaults.each do |k, v|
      self.send("#{k}=", v)
    end

    self
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

  def generate_password
    if self.force_random_password
      self.password = self.password_confirmation = Devise.friendly_token.first(8)
    end
  end

  def generate_reset_token
    @reset_token, enc = Devise.token_generator.generate(self.class, :reset_password_token)

    self.reset_password_token   = enc
    self.reset_password_sent_at = Time.now.utc

    @reset_token
  end

  def private_token
    authentication_token
  end

  def to_s
    name
  end

  def public_profile?
    visibility_level.nil? || public?
  end

  def visibility_level_field
    visibility_level
  end

  def emails
    puts "This is a stub - need to create emails association"
    []
  end
end
