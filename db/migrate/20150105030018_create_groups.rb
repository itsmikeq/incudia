class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :description
      t.references :owner, polymorphic: true, index: true
      t.integer :visibility_level

      t.timestamps null: false
    end
  end
end
