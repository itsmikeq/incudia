class CreateEmbeddedContents < ActiveRecord::Migration
  def change
    create_table :embedded_contents do |t|
      t.string :url
      t.references :owner, polymorphic: true, index: true
      t.string :owner_type

      t.timestamps null: false
    end
  end
end
