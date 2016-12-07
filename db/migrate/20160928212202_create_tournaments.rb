class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
        t.text :name
        t.timestamps null: false
        t.integer :is_private
        t.integer :golf_course_id
        t.integer :price
    end
  end
end
