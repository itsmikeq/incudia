class AddRoleToMembership < ActiveRecord::Migration
  def change
    add_column :memberships, :role, :integer
    add_index :memberships, :role
  end
end
