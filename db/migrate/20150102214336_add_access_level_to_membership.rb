class AddAccessLevelToMembership < ActiveRecord::Migration
  def change
    add_column :memberships, :access_level, :integer
    add_index :memberships, :access_level
  end
end
