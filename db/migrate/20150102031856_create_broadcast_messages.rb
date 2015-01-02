class CreateBroadcastMessages < ActiveRecord::Migration
  def change
    create_table :broadcast_messages do |t|
      t.string :message
      t.datetime :expire_in
      t.datetime :start_at

      t.timestamps null: false
    end
  end
end
