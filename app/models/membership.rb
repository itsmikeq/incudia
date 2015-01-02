# == Schema Information
#
# Table name: memberships
#
#  id         :integer          not null, primary key
#  member_id  :integer
#  of_id      :integer
#  of_type    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_memberships_on_member_id          (member_id)
#  index_memberships_on_of_type_and_of_id  (of_type,of_id)
#

class Membership < ActiveRecord::Base
  belongs_to :member, polymorphic: true
  belongs_to :of, polymorphic: true
end
