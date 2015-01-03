class CreateSocialNets < ActiveRecord::Migration
  def change
    create_table :social_nets do |t|
      t.string :name
      t.string :api_url

      t.timestamps null: false
    end
  end
end
