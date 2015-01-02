# == Schema Information
#
# Table name: areas_users
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  area_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_areas_users_on_area_id  (area_id)
#  index_areas_users_on_user_id  (user_id)
#

class AreasUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :area
end
