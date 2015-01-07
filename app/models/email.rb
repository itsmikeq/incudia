# == Schema Information
#
# Table name: emails
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  verified   :boolean
#
# Indexes
#
#  index_emails_on_user_id  (user_id)
#

class Email < ActiveRecord::Base
  # belongs_to :user
  belongs_to :user
  validates_presence_of :email
  validates_uniqueness_of :email, :scope => [:user]
  after_create :send_verification_email
  after_update :send_verification_email, if: :email_changed?

  def send_verification_email
    Incudia::Logger.warn "Need to imlement send_verification_email for Email class!"
  end
end
