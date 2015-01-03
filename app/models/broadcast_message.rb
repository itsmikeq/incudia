# == Schema Information
#
# Table name: broadcast_messages
#
#  id         :integer          not null, primary key
#  message    :string
#  ends_at    :datetime
#  starts_at  :datetime
#  alert_type :integer
#  color      :string
#  font       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BroadcastMessage < ActiveRecord::Base
  validates :message, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true

  validates :color, format: { with: /\A\#[0-9A-Fa-f]{3}{1,2}+\Z/ }, allow_blank: true
  validates :font,  format: { with: /\A\#[0-9A-Fa-f]{3}{1,2}+\Z/ }, allow_blank: true

  def self.current
    where("ends_at > :now AND starts_at < :now", now: Time.zone.now).last
  end

end
