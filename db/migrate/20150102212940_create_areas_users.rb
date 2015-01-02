class CreateAreasUsers < ActiveRecord::Migration
  def change
    create_table :areas_users do |t|
      t.references :user, index: true
      t.references :area, index: true

      t.timestamps null: false
    end
    add_foreign_key :areas_users, :users
    add_foreign_key :areas_users, :areas
  end
end
