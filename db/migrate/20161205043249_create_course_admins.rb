class CreateCourseAdmins < ActiveRecord::Migration[5.0]
  def change
    create_table :course_admins do |t|
      t.integer :golf_course_id 
      t.integer :admin_id
      t.timestamps
    end
  end
end
