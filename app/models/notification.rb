# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  type       :string
#  message    :text
#  from_id    :integer
#  from_type  :string
#  to_id      :integer
#  to_type    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_notifications_on_from_type_and_from_id  (from_type,from_id)
#  index_notifications_on_to_type_and_to_id      (to_type,to_id)
#  index_notifications_on_type                   (type)
#

class Notification < ActiveRecord::Base
  belongs_to :from, polymorphic: true
  belongs_to :to, polymorphic: true
end
