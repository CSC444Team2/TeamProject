class Sponsor < ApplicationRecord
	belongs_to :person, class_name: "User"
	belongs_to :event, class_name: "Tournament"
	
	validates :person_id, presence: true
	validates :event_id, presence: true

	def paypal_url(return_path)
		values = {
				business: "csc444.toronto-merchant@gmail.com",
				cmd: "_xclick",
				upload: 1,
				return: "www.google.com", #"#{Rails.application.secrets.app_host}#{return_path}",
				invoice: id,
				amount: 90,
				item_name: sponsoring,
				item_number: 2,
				quantity: '1'
		}
		"#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
	end
end
