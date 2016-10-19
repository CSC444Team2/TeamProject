class CreateOrganizes < ActiveRecord::Migration[5.0]
  def change
    create_table :organizes do |t|
      t.integer :event_id
      t.integer :person_id
      t.timestamps
    end

    add_index :organizes, :event_id
    add_index :organizes, :person_id
    add_index :organizes, [:event_id, :person_id], unique:true
  end
end
