# == Schema Information
#
# Table name: focalpoints_users
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  focalpoint_id :integer
#  role          :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_focalpoints_users_on_focalpoint_id  (focalpoint_id)
#  index_focalpoints_users_on_user_id        (user_id)
#

class FocalpointsUser < ActiveRecord::Base
  include Incudia::Role
  belongs_to :user
  belongs_to :focalpoint

  default_value_for :role, LEVELS[:participant]

  def access_field
    role
  end
end
