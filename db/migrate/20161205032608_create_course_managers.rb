class CreateCourseManagers < ActiveRecord::Migration[5.0]
  def change
    create_table :course_managers do |t|
      t.integer :golf_course_id 
      t.integer :manager_id
      t.timestamps
    end
  end
end
