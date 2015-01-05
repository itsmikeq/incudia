class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.references :user, index: true
      t.string :email

      t.timestamps null: false
    end
    add_foreign_key :emails, :users
  end
end
