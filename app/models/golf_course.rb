class GolfCourse < ApplicationRecord
	before_destroy {
		Tournament.all.each do |t|
			if t.golf_course_id == self.id
				t.golf_course_id = nil
				t.save
			end
		end
	}

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

	has_many :received_requests, class_name: "GolfRequest", foreign_key: "receiver_id",
			dependent: :destroy
	def received_admin_requests
		@admin_requests = []
		received_requests.each do |req|
			if received_requests.golf_request_type == 0
				@admin_requests << req
			end
		end
		return @admin_requests
	end
	def received_csr_requests
		@csr_requests = []
		received_requests.each do |req|
			if received_requests.golf_request_type == 1
				@csr_requests << req
			end
		end
		return @csr_requests
	end
end
