# == Schema Information
#
# Table name: admin_ext_services
#
#  id         :integer          not null, primary key
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Admin::ExtService < ActiveRecord::Base
end
