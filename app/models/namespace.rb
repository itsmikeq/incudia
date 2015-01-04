# == Schema Information
#
# Table name: namespaces
#
#  id               :integer          not null, primary key
#  name             :string
#  description      :string
#  owner_id         :integer
#  owner_type       :string
#  type             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  visibility_level :integer
#
# Indexes
#
#  index_namespaces_on_name                     (name) UNIQUE
#  index_namespaces_on_owner_type_and_owner_id  (owner_type,owner_id)
#  index_namespaces_on_type                     (type)
#  index_namespaces_on_visibility_level         (visibility_level)
#

class Namespace < ActiveRecord::Base
  include Incudia::VisibilityLevel
  belongs_to :owner, polymorphic: true

  default_value_for :visibility_level, PUBLIC
  validates_presence_of :name
  validates_presence_of :description
  validates_uniqueness_of :name
  validates_inclusion_of :visibility_level, in: Incudia::VisibilityLevel.values

  delegate :name, to: :owner, allow_nil: true, prefix: true
end
