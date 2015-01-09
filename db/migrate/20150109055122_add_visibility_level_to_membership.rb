class AddVisibilityLevelToMembership < ActiveRecord::Migration
  def change
    add_column :memberships, :visibility_level, :integer
  end
end
