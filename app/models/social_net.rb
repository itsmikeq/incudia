# == Schema Information
#
# Table name: social_nets
#
#  id         :integer          not null, primary key
#  name       :string
#  api_url    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  enabled    :boolean
#
require 'uri'

class SocialNet < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :api_url
  validates_uniqueness_of :name, message: "The name has already been taken"
  validates_uniqueness_of :api_url, message: "The API URL has already been defined"
  has_one :ext_service
  before_save :validate_api_url
  has_many :social_nets_users, dependent: :destroy
  has_many :users, through: :social_nets_users

  default_value_for :enabled, false

  def validate_api_url
    (api_url =~ /\A#{URI::regexp}\z/) ? true : false
  end
end
