class CreateExtServices < ActiveRecord::Migration
  def change
    create_table :ext_services do |t|
      t.references :ext_service, index: true
      t.references :consumer, polymorphic: true, index: true

      t.timestamps null: false
    end
    add_foreign_key :ext_services, :ext_services
  end
end
