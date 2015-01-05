# == Schema Information
#
# Table name: emails
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_emails_on_user_id  (user_id)
#

class Email < ActiveRecord::Base
  belongs_to :user
end
