class CourseManager < ApplicationRecord
	belongs_to :manager, class_name: "User"
	belongs_to :golf_course, class_name: "GolfCourse"

	validates :golf_course_id, presence: true
	validates :manager_id, presence: true
end
