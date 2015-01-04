# == Schema Information
#
# Table name: focalpoints
#
#  id               :integer          not null, primary key
#  area_id          :integer
#  area_type        :string
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
#  index_focalpoints_on_area_type_and_area_id    (area_type,area_id)
#  index_focalpoints_on_name                     (name) UNIQUE
#  index_focalpoints_on_owner_type_and_owner_id  (owner_type,owner_id)
#  index_focalpoints_on_visibility_level         (visibility_level)
#

class Focalpoint < ActiveRecord::Base
  include Incudia::VisibilityLevel
  belongs_to :area, polymorphic: true
  belongs_to :owner, polymorphic: true
  validates_presence_of :name
  validates_presence_of :description
  validates_uniqueness_of :name, scope: [:visibility_level]
  validates_inclusion_of :visibility_level, in: Incudia::VisibilityLevel.values

  default_value_for :visibility_level, PUBLIC

  def visibility_level_field
    visibility_level
  end
end
