class AddEnabledToSocialNet < ActiveRecord::Migration
  def change
    add_column :social_nets, :enabled, :boolean
  end
end
