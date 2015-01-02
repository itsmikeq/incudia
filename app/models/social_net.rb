# == Schema Information
#
# Table name: social_nets
#
#  id         :integer          not null, primary key
#  name       :string
#  auth_api   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SocialNet < ActiveRecord::Base
end
