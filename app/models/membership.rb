# == Schema Information
#
# Table name: memberships
#
#  id           :integer          not null, primary key
#  member_id    :integer
#  of_id        :integer
#  of_type      :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  access_level :integer
#
# Indexes
#
#  index_memberships_on_access_level       (access_level)
#  index_memberships_on_member_id          (member_id)
#  index_memberships_on_of_type_and_of_id  (of_type,of_id)
#

# This class will track all memberships of users->groups->interests and areas
class Membership < ActiveRecord::Base
  belongs_to :member, polymorphic: true
  belongs_to :of, polymorphic: true
end
