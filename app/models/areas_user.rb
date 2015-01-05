# == Schema Information
#
# Table name: areas_users
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  area_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  role       :integer
#
# Indexes
#
#  index_areas_users_on_area_id  (area_id)
#  index_areas_users_on_role     (role)
#  index_areas_users_on_user_id  (user_id)
#

class AreasUser < ActiveRecord::Base
  include Incudia::Role
  belongs_to :user
  belongs_to :area
  validates_presence_of :user
  validates_presence_of :area

  default_value_for :role, LEVELS[:participant]
  def access_field
    role
  end

end
