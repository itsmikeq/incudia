# == Schema Information
#
# Table name: groups
#
#  id               :integer          not null, primary key
#  name             :string
#  description      :string
#  owner_id         :integer
#  owner_type       :string
#  visibility_level :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_groups_on_owner_type_and_owner_id  (owner_type,owner_id)
#

require 'rails_helper'

RSpec.describe Group, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
