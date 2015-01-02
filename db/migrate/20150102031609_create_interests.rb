class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.string :name
      t.string :description
      t.string :type
      t.references :owner, polymorphic: true, index: true

      t.timestamps null: false
    end
    add_index :interests, :name
    add_index :interests, :type
  end
end
