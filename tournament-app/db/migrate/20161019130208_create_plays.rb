class CreatePlays < ActiveRecord::Migration[5.0]
  def change
    create_table :plays do |t|
      t.integer :event_id
      t.integer :person_id

      t.timestamps
    end
    add_index :plays, :event_id
    add_index :plays, :person_id
    add_index :plays, [:event_id, :person_id], unique:true
  end
end
