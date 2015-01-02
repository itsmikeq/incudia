# == Schema Information
#
# Table name: ext_services
#
#  id             :integer          not null, primary key
#  ext_service_id :integer
#  consumer_id    :integer
#  consumer_type  :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_ext_services_on_consumer_type_and_consumer_id  (consumer_type,consumer_id)
#  index_ext_services_on_ext_service_id                 (ext_service_id)
#

class ExtService < ActiveRecord::Base
  belongs_to :ext_service
  belongs_to :consumer, polymorphic: true
end
