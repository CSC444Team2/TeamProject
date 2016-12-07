class Play < ApplicationRecord
	belongs_to :person, class_name: "User"
	belongs_to :event, class_name: "Tournament"
	
	validates :person_id, presence: true
	validates :event_id, presence: true
end
