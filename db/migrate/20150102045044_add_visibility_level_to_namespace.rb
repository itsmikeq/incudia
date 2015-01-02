class AddVisibilityLevelToNamespace < ActiveRecord::Migration
  def change
    add_column :namespaces, :visibility_level, :integer
    add_index :namespaces, :visibility_level
  end
end
