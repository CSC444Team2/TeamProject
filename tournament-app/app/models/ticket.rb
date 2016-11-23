class Ticket < ApplicationRecord
	belongs_to :person, class_name: "User"
	belongs_to :event, class_name: "Tournament"
end
