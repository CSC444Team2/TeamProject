class User < ActiveRecord::Base
	#Personal info
	before_save { self.email = email.downcase }
	validates :first_name, presence: true, length: { maximum: 50 }
	validates :last_name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
		format: { with: VALID_EMAIL_REGEX },
		uniqueness: { case_sensitive: false }

	#Password
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }

	#Involvements
	has_many :player_involvements, class_name: "Play", foreign_key: "person_id",
									dependent: :destroy
	has_many :played_events, through: :player_involvements, source: :event

	def play_in(some_event)
		player_involvements.create(event_id: some_event.id)
	end
	def not_play(some_event)
		player_involvements.find_by(event_id: some_event.id).destroy
	end
	def played_in?(some_event)
		played_events.include?(some_event)
	end

	has_many :organizer_involvements, class_name: "Organize", foreign_key: "person_id",
									dependent: :destroy
	has_many :organized_events, through: :organizer_involvements, source: :event
	def organize_a(some_event)
		organizer_involvements.create(event_id: some_event.id)
	end
	def not_organize(some_event)
		organizer_involvements.find_by(event_id: some_event.id).destroy
	end
	def organized_a?(some_event)
		organized_events.include?(some_event)
	end

	has_many :sponsor_involvements, class_name: "Sponsor", foreign_key: "person_id"
	has_many :sponsored_events, through: :sponsor_involvements, source: :event
	def sponsor_a(some_event)
		sponsor_involvements.create(event_id: some_event.id)
	end
	def not_sponsor(some_event)
		sponsor_involvements.find_by(event_id: some_event.id).destroy
	end
	def sponsored_a?(some_event)
		sponsored_events.include?(some_event)
	end

	#Requests
	has_many :sent_requests, class_name: "Request", foreign_key: "sender_id",
			dependent: :destroy
	has_many :wanted_events, through: :sent_requests, source: :receiver
	def send_request(some_event, some_message)
		request = sent_requests.create(receiver_id: some_event.id, message: some_message)
	end
	def received_requests
		requests=[]
		organized_events.each do |e|
			e.received_requests.each do |new_request|
				requests << new_request
			end
		end
		return requests
	end
end
