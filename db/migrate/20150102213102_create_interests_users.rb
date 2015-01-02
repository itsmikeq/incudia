class CreateInterestsUsers < ActiveRecord::Migration
  def change
    create_table :interests_users do |t|
      t.references :user, index: true
      t.references :interest, index: true

      t.timestamps null: false
    end
    add_foreign_key :interests_users, :users
    add_foreign_key :interests_users, :interests
  end
end
