# == Schema Information
#
# Table name: interests
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  type        :string
#  owner_id    :integer
#  owner_type  :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_interests_on_name                     (name)
#  index_interests_on_owner_type_and_owner_id  (owner_type,owner_id)
#  index_interests_on_type                     (type)
#

require 'rails_helper'

RSpec.describe Interest, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
