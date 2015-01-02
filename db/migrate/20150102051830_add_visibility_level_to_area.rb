class AddVisibilityLevelToArea < ActiveRecord::Migration
  def change
    add_column :areas, :visibility_level, :integer
    add_index :areas, :visibility_level
  end
end
