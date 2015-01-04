class AddVerifiedToSocialNetsUser < ActiveRecord::Migration
  def change
    add_column :social_nets_users, :verified, :boolean
    add_index :social_nets_users, :verified
  end
end
