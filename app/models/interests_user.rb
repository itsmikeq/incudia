# == Schema Information
#
# Table name: interests_users
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  interest_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  role        :integer
#
# Indexes
#
#  index_interests_users_on_interest_id  (interest_id)
#  index_interests_users_on_role         (role)
#  index_interests_users_on_user_id      (user_id)
#

class InterestsUser < ActiveRecord::Base
  include Incudia::Role
  belongs_to :user
  belongs_to :interest

  default_value_for :role, LEVELS[:participant]
  def access_field
    role
  end

end
