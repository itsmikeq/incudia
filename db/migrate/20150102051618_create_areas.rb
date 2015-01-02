class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :name
      t.string :description
      t.integer :owner_id, index: true

      t.timestamps null: false
    end
  end
end
