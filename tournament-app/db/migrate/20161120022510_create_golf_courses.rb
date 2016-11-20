class CreateGolfCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :golf_courses do |t|
      t.text :name
      t.text :overview
      t.text :address
      t.text :website
      t.text :contact_info
      t.timestamps
    end
  end
end
