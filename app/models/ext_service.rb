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

# These are the external services, to be created by the admin and should have a specific class
# Associated to it so that we can hit the service correctly. Really, we will pre-populate the
# info in this class and this class allow us to enable or disable them
class ExtService < ActiveRecord::Base
  belongs_to :social_net
  belongs_to :consumer, polymorphic: true
end
