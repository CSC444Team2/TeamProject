class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.integer :sender_id
      t.integer :receiver_id #receiver is an event
      t.string :message
      t.timestamps
    end
  end
end
