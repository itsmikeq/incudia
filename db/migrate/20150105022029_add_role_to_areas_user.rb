class AddRoleToAreasUser < ActiveRecord::Migration
  def change
    add_column :areas_users, :role, :integer
    add_index :areas_users, :role
  end
end
