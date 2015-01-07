class AddVerifiedToEmail < ActiveRecord::Migration
  def change
    add_column :emails, :verified, :boolean
  end
end
