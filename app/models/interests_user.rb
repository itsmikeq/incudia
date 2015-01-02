# == Schema Information
#
# Table name: interests_users
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  interest_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_interests_users_on_interest_id  (interest_id)
#  index_interests_users_on_user_id      (user_id)
#

class InterestsUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :interest, dependant: :destroy
end
