class AddVisibilityLevelToInterest < ActiveRecord::Migration
  def change
    add_column :interests, :visibility_level, :integer
  end
end
