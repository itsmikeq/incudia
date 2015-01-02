class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :type
      t.text :message
      t.references :from, polymorphic: true, index: true
      t.references :to, polymorphic: true, index: true

      t.timestamps null: false
    end
    add_index :notifications, :type
  end
end
