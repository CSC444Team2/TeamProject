class CourseAdmin < ApplicationRecord
	belongs_to :admin, class_name: "User"
	belongs_to :golf_course, class_name: "GolfCourse"

	validates :golf_course_id, presence: true
	validates :admin_id, presence: true
end
