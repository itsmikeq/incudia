# == Schema Information
#
# Table name: interests
#
#  id               :integer          not null, primary key
#  name             :string
#  description      :string
#  type             :string
#  owner_id         :integer
#  owner_type       :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  visibility_level :integer
#
# Indexes
#
#  index_interests_on_name                     (name)
#  index_interests_on_owner_type_and_owner_id  (owner_type,owner_id)
#  index_interests_on_type                     (type)
#

class Interest < ActiveRecord::Base
  # TODO: Wedge in some intelligence for assigning a new user when the owner is deleted
include Incudia::VisibilityLevel
  belongs_to :owner, polymorphic: true
  has_many :interests_users, dependent: :destroy
  has_many :users, through: :interests_users
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :owner

  validates_inclusion_of :visibility_level, in: Incudia::VisibilityLevel.values

  scope :without_users, -> {InterestsUser.joins(:interest).where("interests.id not in (#{InterestsUser.pluck(:interest_id).uniq})")}

  default_value_for :visibility_level, PUBLIC

  def visibility_level_field
    visibility_level
  end
end
