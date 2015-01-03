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

require 'rails_helper'

RSpec.describe SocialNet, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
