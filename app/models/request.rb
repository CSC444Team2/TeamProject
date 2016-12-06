class Request < ApplicationRecord
	belongs_to :sender, class_name: "User"
	belongs_to :receiver, class_name: "Tournament"

	validates :sender_id, presence: true
	validates :receiver_id, presence: true
	validates :message, length: {maximum: 200}
end
