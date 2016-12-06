class GolfRequest < ApplicationRecord
	belongs_to :sender, class_name: "User"
	belongs_to :receiver, class_name: "GolfCourse"

	validates :sender_id, presence: true
	validates :receiver_id, presence: true
	validates :golf_request_type, presence: true
	validates :message, length: {maximum: 200}
end
