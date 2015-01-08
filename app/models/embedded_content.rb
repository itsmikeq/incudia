# == Schema Information
#
# Table name: embedded_contents
#
#  id         :integer          not null, primary key
#  url        :string
#  owner_id   :integer
#  owner_type :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_embedded_contents_on_owner_type_and_owner_id  (owner_type,owner_id)
#

class EmbeddedContent < ActiveRecord::Base
  belongs_to :owner, polymorphic: true
end
