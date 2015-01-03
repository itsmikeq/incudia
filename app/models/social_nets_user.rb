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
#
# Indexes
#
#  index_social_nets_users_on_social_net_id  (social_net_id)
#  index_social_nets_users_on_user_id        (user_id)
#

class SocialNetsUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :social_net
end
