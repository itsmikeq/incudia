class CreateFocalpointsUsers < ActiveRecord::Migration
  def change
    create_table :focalpoints_users do |t|
      t.references :user, index: true
      t.references :focalpoint, index: true
      t.integer :role

      t.timestamps null: false
    end
    add_foreign_key :focalpoints_users, :users
    add_foreign_key :focalpoints_users, :focalpoints
  end
end
