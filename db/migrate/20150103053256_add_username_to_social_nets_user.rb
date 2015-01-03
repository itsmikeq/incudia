class AddUsernameToSocialNetsUser < ActiveRecord::Migration
  def change
    add_column :social_nets_users, :username, :string
  end
end
