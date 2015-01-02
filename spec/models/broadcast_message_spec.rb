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

require 'rails_helper'

RSpec.describe BroadcastMessage, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
