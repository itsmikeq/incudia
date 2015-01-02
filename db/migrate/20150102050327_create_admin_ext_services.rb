class CreateAdminExtServices < ActiveRecord::Migration
  def change
    create_table :admin_ext_services do |t|
      t.string :url

      t.timestamps null: false
    end
  end
end
