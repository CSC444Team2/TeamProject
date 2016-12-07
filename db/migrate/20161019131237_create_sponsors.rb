class CreateSponsors < ActiveRecord::Migration[5.0]
  def change
    create_table :sponsors do |t|
      t.integer :event_id
      t.integer :person_id
      t.timestamps
    end

    add_index :sponsors, :event_id
    add_index :sponsors, :person_id
    add_index :sponsors, [:event_id, :person_id], unique:true
  end
end
