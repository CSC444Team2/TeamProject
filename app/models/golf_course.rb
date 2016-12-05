class GolfCourse < ApplicationRecord
	validates :name, presence: true
	validates :address, presence: true
	validates :overview, length: { maximum: 200 }

	has_many :admin_rel, class_name: "CourseAdmin", foreign_key: "golf_course_id",
			dependent: :destroy
	has_many :admins, through: :admin_rel, source: :admin
	def got_admin?(some_admin)
		admins.include?(some_admin)
	end

	has_many :manage_rel, class_name: "CourseManager", foreign_key: "golf_course_id",
			dependent: :destroy
	has_many :managers, through: :manage_rel, source: :manager
	def got_manager?(some_manager)
		managers.include?(some_manager)
	end
end
