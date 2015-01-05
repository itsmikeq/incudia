# == Schema Information
#
# Table name: groups
#
#  id               :integer          not null, primary key
#  name             :string
#  description      :string
#  owner_id         :integer
#  owner_type       :string
#  visibility_level :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_groups_on_owner_type_and_owner_id  (owner_type,owner_id)
#

class Group < ActiveRecord::Base
  include Incudia::VisibilityLevel

  belongs_to :owner, polymorphic: true # Can be a User, Group, etc.

  # Membership has the `of` and `member` types.  Since the User is a member OF group,
  # Group is the :of type, set here
  has_many :memberships, as: :of
  # This maps the Membership to User where the of_id matches Group.id
  has_many :members, through: :memberships, source: "member", source_type: "User"
  validates_inclusion_of :visibility_level, in: Incudia::VisibilityLevel.values
  validates_presence_of :name
  validates_presence_of :description
  validates_uniqueness_of :name
  default_value_for :visibility_level, PUBLIC

  # public is a reserved word
  scope :publics, -> { where(visibility_level: PUBLIC) }

  def visibility_level_field
    visibility_level
  end
end
