# == Schema Information
#
# Table name: focals
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
#  index_focals_on_area_type_and_area_id    (area_type,area_id)
#  index_focals_on_name                     (name) UNIQUE
#  index_focals_on_owner_type_and_owner_id  (owner_type,owner_id)
#  index_focals_on_visibility_level         (visibility_level)
#

class Focal < ActiveRecord::Base
  belongs_to :area, polymorphic: true
  belongs_to :owner, polymorphic: true
end
