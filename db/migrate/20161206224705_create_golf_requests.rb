class CreateGolfRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :golf_requests do |t|
      t.integer :sender_id
      t.integer :receiver_id #receiver is an event
      t.integer :golf_request_type #0 - admin; 1 - CSR/manager
      t.string :message
      t.timestamps
    end
  end
end
