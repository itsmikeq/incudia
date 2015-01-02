class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :member, index: true
      t.references :of, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
