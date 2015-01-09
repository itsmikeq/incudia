# == Schema Information
#
# Table name: memberships
#
#  id               :integer          not null, primary key
#  member_id        :integer
#  member_type      :string
#  of_id            :integer
#  of_type          :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  role             :integer
#  visibility_level :integer
#
# Indexes
#
#  index_memberships_on_member_type_and_member_id  (member_type,member_id)
#  index_memberships_on_of_type_and_of_id          (of_type,of_id)
#  index_memberships_on_role                       (role)
#

# This class will track all memberships of users->groups->interests and areas
# This will probably be a bottleneck and should be refactored.... As soon as I figure out how
# All of the membership.of classes MUST response to :name
class Membership < ActiveRecord::Base
  include Incudia::Role
  include Incudia::VisibilityLevel
  belongs_to :member, polymorphic: true
  belongs_to :of, polymorphic: true
  validates_inclusion_of :visibility_level, in: Incudia::VisibilityLevel.values
  delegate :name, :description, to: :of, prefix: true

  scope :publics, -> { where(visibility_level: PUBLIC) }
  scope :owners, ->(of_id) { where(of_id: of_id, role: LEVELS[:owner]) }

  default_value_for :visibility_level, PUBLIC
  default_value_for :role, LEVELS[:participant]
  validates_uniqueness_of :member_id, scope: [:of], message: "Already a member"

  def access_field
    :role
  end

  def visibility_level_field
    visibility_level
  end

end
