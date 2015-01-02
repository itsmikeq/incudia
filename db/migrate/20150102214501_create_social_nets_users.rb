class CreateSocialNetsUsers < ActiveRecord::Migration
  def change
    create_table :social_nets_users do |t|
      t.references :user, index: true
      t.references :social_net, index: true

      t.timestamps null: false
    end
    add_foreign_key :social_nets_users, :users
    add_foreign_key :social_nets_users, :social_nets
  end
end
