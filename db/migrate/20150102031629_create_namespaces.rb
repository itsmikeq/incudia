class CreateNamespaces < ActiveRecord::Migration
  def change
    create_table :namespaces do |t|
      t.string :name
      t.string :description
      t.references :owner, polymorphic: true, index: true
      t.string :type

      t.timestamps null: false
    end
    add_index :namespaces, :name, unique: true
    add_index :namespaces, :type
  end
end
