class CreatePlayergroups < ActiveRecord::Migration[5.0]
  def change
    create_table :playergroups do |t|
      t.text :group_members
      t.integer :tournament_id
      t.timestamps
    end
  end
end
