# == Schema Information
#
# Table name: areas
#
#  id               :integer          not null, primary key
#  name             :string
#  description      :string
#  owner_id         :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  visibility_level :integer
#  owner_type       :string
#
# Indexes
#
#  index_areas_on_owner_id          (owner_id)
#  index_areas_on_visibility_level  (visibility_level)
#

class Area < ActiveRecord::Base
  # TODO: Wedge in some intelligence for assigning a new user when the owner is deleted
include Incudia::VisibilityLevel
  belongs_to :owner, polymorphic: true
  has_many :areas_users, dependent: :destroy
  has_many :users, through: :areas_users
  has_many :focalpoints
  validates_presence_of :name
  validates_presence_of :description
  validates_uniqueness_of :name, scope: [:owner]
  validates_inclusion_of :visibility_level, in: Incudia::VisibilityLevel.values

  default_value_for :visibility_level, PUBLIC

  scope :without_focalpoints, ->{ where("id not in (?)", Focalpoint.pluck(:area_id))}

  def visibility_level_field
    visibility_level
  end
end
