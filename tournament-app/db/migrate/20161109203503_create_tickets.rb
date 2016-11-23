class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.integer :event_id
      t.integer :person_id
      t.timestamps
    end

    add_index :tickets, :event_id
    add_index :tickets, :person_id
    add_index :tickets, [:event_id, :person_id], unique:true
    end
  end
end
