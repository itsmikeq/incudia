class AddOwnerTypeToArea < ActiveRecord::Migration
  def change
    add_column :areas, :owner_type, :string
  end
end
