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
  belongs_to :owner
  has_many :focal_points
end
