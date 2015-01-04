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
#
# Indexes
#
#  index_areas_on_owner_id          (owner_id)
#  index_areas_on_visibility_level  (visibility_level)
#

class Area < ActiveRecord::Base
  includes Incudia::VisibilityLevel
  belongs_to :owner
  has_many :focalpoints
  validates_presence_of :name
  validates_presence_of :description
  validates_uniqueness_of :name, scope: [:visibility_level]
  validates_inclusion_of :visibility_level, in: Incudia::VisibilityLevel.values

  default_value_for :visibility_level, PUBLIC

  def visibility_level_field
    visibility_level
  end
end
