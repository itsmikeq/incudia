class AddRoleToInterestsUser < ActiveRecord::Migration
  def change
    add_column :interests_users, :role, :integer
    add_index :interests_users, :role
  end
end
