class CreateFocals < ActiveRecord::Migration
  def change
    create_table :focals do |t|
      t.references :area, polymorphic: true, index: true
      t.string :name
      t.string :description
      t.references :owner, polymorphic: true, index: true
      t.integer :visibility_level

      t.timestamps null: false
    end
    add_index :focals, :name, unique: true
    add_index :focals, :visibility_level
  end
end
