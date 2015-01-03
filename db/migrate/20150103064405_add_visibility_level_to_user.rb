class AddVisibilityLevelToUser < ActiveRecord::Migration
  def change
    add_column :users, :visibility_level, :integer
  end
end
