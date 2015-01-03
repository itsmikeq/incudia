class CreateExtServices < ActiveRecord::Migration
  def change
    create_table :ext_services do |t|
      t.references :social_net, index: true
      t.references :consumer, polymorphic: true, index: true

      t.timestamps null: false
    end
    add_foreign_key :ext_services, :social_nets
  end
end
