# == Schema Information
#
# Table name: ext_services
#
#  id            :integer          not null, primary key
#  social_net_id :integer
#  consumer_id   :integer
#  consumer_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_ext_services_on_consumer_type_and_consumer_id  (consumer_type,consumer_id)
#  index_ext_services_on_social_net_id                  (social_net_id)
#

require 'rails_helper'

RSpec.describe ExtService, :type => :model do
  it {should belong_to(:social_net)}
  it {should belong_to(:consumer)}
end
