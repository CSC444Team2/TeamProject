class CreatePlayergroups < ActiveRecord::Migration[5.0]
  def change
    create_table :playergroups do |t|
      t.integer :group_members, array: true, default: []
      t.timestamps
    end
  end
end
