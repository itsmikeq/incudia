# == Schema Information
#
# Table name: social_nets
#
#  id         :integer          not null, primary key
#  name       :string
#  api_url    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  enabled    :boolean
#

class SocialNet < ActiveRecord::Base
  default_value_for :enabled, false
end
