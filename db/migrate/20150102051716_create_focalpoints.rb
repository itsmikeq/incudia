class CreateFocalpoints < ActiveRecord::Migration
  def change
    create_table :focalpoints do |t|
      t.references :area, polymorphic: true, index: true
      t.string :name
      t.string :description
      t.references :owner, polymorphic: true, index: true
      t.integer :visibility_level

      t.timestamps null: false
    end
    add_index :focalpoints, :name, unique: true
    add_index :focalpoints, :visibility_level
  end
end
