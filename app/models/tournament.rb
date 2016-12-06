class Tournament < ActiveRecord::Base
	#Players/Organizers/Sponsors Roles
	validates :name, presence: true, length: { maximum: 50 }
	validates :description, length: {maximum: 300}
	#Tickets
	has_many :tickets
	has_many :user, through: :tickets

	has_many :player_attendings, class_name: "Play", foreign_key: "event_id",
									dependent: :destroy
	has_many :players, through: :player_attendings, source: :person
	def got_player?(some_player)
		players.include?(some_player)
	end


	has_many :organizer_attendings, class_name: "Organize", foreign_key: "event_id"
	has_many :organizers, through: :organizer_attendings, source: :person
	def got_organizer?(some_organizer)
		organizers.include?(some_organizer)
	end

	has_many :sponsor_attendings, class_name: "Sponsor", foreign_key: "event_id"
	has_many :sponsors, through: :sponsor_attendings, source: :person
	def got_sponsor?(some_sponsor)
		sponsors.include?(some_sponsor)
	end

	#Request
	has_many :received_requests, class_name: "Request", foreign_key: "receiver_id",
			dependent: :destroy

	#Player groups
	has_many :player_groups, class_name: "Playergroup", foreign_key: "tournament_id"
	def new_group
		pg = player_groups.create(tournament_id: self.id)
		return pg
	end
end
