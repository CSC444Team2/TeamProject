class CreatePlayerGroups < ActiveRecord::Migration
  def change
    create_table :player_groups do |t|

      t.timestamps null: false
    end
  end
end
