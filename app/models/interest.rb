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

class Interest < ActiveRecord::Base
  belongs_to :owner, polymorphic: true
end
