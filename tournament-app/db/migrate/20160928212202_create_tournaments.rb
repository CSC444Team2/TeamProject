class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
        t.text :name
        t.timestamps null: false
    end
  end
end
