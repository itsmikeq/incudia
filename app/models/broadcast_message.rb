# == Schema Information
#
# Table name: broadcast_messages
#
#  id         :integer          not null, primary key
#  message    :string
#  expire_in  :datetime
#  start_at   :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BroadcastMessage < ActiveRecord::Base
end
