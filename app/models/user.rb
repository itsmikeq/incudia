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
#  state                  :string
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
  has_many :areas, through: :areas_users
  # has_many :interests_users, dependent: :destroy
  # has_many :interests, through: :interests_users
  has_many :interests, through: :memberships, source: "of", source_type: "Interest", dependent: :destroy
  has_many :memberships, as: :member # This is wonky but works, returns 0 but will return for groups
  has_many :groups, through: :memberships, source: "of", source_type: "Group", dependent: :destroy
  has_many :areas, through: :memberships, source: "of", source_type: "Area", dependent: :destroy
  has_many :companies, through: :memberships, source: "of", source_type: "Company", dependent: :destroy
  # has_many :companies, as: :owner
  has_many :embedded_contents, as: :owner # This is wonky but works, returns 0 but will return for groups

  # Identity-related
  has_many :identities, dependent: :destroy
  has_many :emails, dependent: :destroy

  accepts_nested_attributes_for :identities, reject_if: lambda { |attributes| attributes['kind'].blank? }

  default_value_for :admin, false
  default_value_for :visibility_level, PUBLIC
  default_value_for :state, :active

  # Validations
  validates :username, presence: true, uniqueness: {case_sensitive: false},
            exclusion:           {in: Incudia::Blacklist.path},
            format:              {with:    Incudia::Regex.username_regex,
                                  message: Incudia::Regex.username_regex_message}

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  # :email
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  scope :admins, -> { where(admin: true) }
  scope :blocked, -> { with_state(:blocked) }
  scope :active, -> { with_state(:active) }

  before_save :ensure_authentication_token

  # Virtual attribute for authenticating by either username or email
  attr_accessor :login
  alias_attribute :private_token, :authentication_token

  # Pagination
  paginates_per 100

  state_machine :state, initial: :active do
    after_transition any => :blocked do |user, transition|
      # Remove user from all memberships and
      user.groups.each do |membership|
        # skip owned resources
        next if membership.access_level == Incudia::Role::LEVELS[:owner]

        return false unless membership.destroy
      end

      # Remove user from all groups
      user.areas.each do |membership|
        # skip owned resources
        next if membership.role == Incudia::Role::LEVELS[:owner]

        return false unless membership.destroy
      end
    end

    event :block do
      transition active: :blocked
    end

    event :activate do
      transition any: :active
    end
  end

  # Class methods
  class << self

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

  def owned_groups
    Group.where(owner: self)
  end

  def owned_interests
    Interest.where(owner: self)
  end

  def owned_areas
    Area.where(owner: self)
  end

  def owned_companies
    Company.where(owner: self)
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

  def local_user?
    provider.nil?
  end
end
