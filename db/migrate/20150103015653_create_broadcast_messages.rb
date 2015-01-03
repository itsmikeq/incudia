class CreateBroadcastMessages < ActiveRecord::Migration
  def change
    create_table :broadcast_messages do |t|
      t.string :message
      t.datetime :ends_at
      t.datetime :starts_at
      t.integer :alert_type
      t.string :color
      t.string :font

      t.timestamps null: false
    end
  end
end
