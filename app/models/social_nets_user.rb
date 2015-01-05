# == Schema Information
#
# Table name: social_nets_users
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  social_net_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  username      :string
#  verified      :boolean
#
# Indexes
#
#  index_social_nets_users_on_social_net_id  (social_net_id)
#  index_social_nets_users_on_user_id        (user_id)
#  index_social_nets_users_on_verified       (verified)
#

# Defines relationships between a user and an external social network
# TODO: the user will need to log in to create the association, this can be done via the Identity class
# TODO: Wedge in some intelligence for assigning a new user when the owner is deleted
class SocialNetsUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :social_net
  default_value_for :verified, false
end
