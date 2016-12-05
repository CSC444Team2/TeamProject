class User < ActiveRecord::Base
	#Personal info
	before_create { generate_token(:auth_token) }
	
	before_save { self.email = email.downcase }
	validates :first_name, presence: true, length: { maximum: 50 }
	validates :last_name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
		format: { with: VALID_EMAIL_REGEX, message: "Not appropriate e-mail address" },
		uniqueness: { case_sensitive: false }

	def get_user_name
		user_name = self.first_name + " " + self.last_name
		return user_name
	end

	#Profile Picture
	has_attached_file :profile_picture, 
	:styles => {large: "600x600>", medium: "300x300>", thumb: "150x150#"},
	:storage => :s3,
	:bucket => 'csc444team2'
	:s3_credentials => S3_CREDENTIALS
	validates_attachment_content_type :profile_picture, content_type: /\Aimage\/.*\Z/\

	#Password
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }, :on => :create

	#Tickets
	#This ticket model will saved all the tickets for this user
	#With tickets_type identify the type of tickets
	has_many :tickets
	has_many :tournaments, through: :tickets

	#========== Tournament Involvements ===============
	has_many :player_involvements, class_name: "Play", foreign_key: "person_id",
									dependent: :destroy
	has_many :played_events, through: :player_involvements, source: :event

	def send_password_reset
		generate_token(:password_reset_token)
		self.password_reset_sent_at = Time.zone.now
        	save!
		UserMailer.password_reset(self).deliver
	end

	def generate_token(column)
	begin
		self[column] = SecureRandom.urlsafe_base64
	end while User.exists?(column => self[column])
	end
	
	
	def play_in(some_event)
		if(!self.played_in?(some_event))
			player_involvements.create(event_id: some_event.id)
		end
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
		if(!self.organized_a?(some_event))
			organizer_involvements.create(event_id: some_event.id)
		end
	end
	def not_organize(some_event)
		organizer_involvements.find_by(event_id: some_event.id).destroy
	end
	def organized_a?(some_event)
		organized_events.include?(some_event)
	end

	has_many :sponsor_involvements, class_name: "Sponsor", foreign_key: "person_id",
									dependent: :destroy
	has_many :sponsored_events, through: :sponsor_involvements, source: :event
	def sponsor_a(some_event)
		if(!self.sponsored_a?(some_event))
			sponsor_involvements.create(event_id: some_event.id)
		end
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
	#has_many :wanted_events, through: :sent_requests, source: :receiver
	def received_requests
		requests=[]
		organized_events.each do |e|
			e.received_requests.each do |new_request|
				requests << new_request
			end
		end
		return requests
  end

  #========== Golf Course Involvements ===============
  has_many :admin_course_rel, class_name: "CourseAdmin", foreign_key: "admin_id",
  								dependent: :destroy
  has_many :admined_courses, through: :admin_course_rel, source: :course

  has_many :manage_course_rel, class_name: "CourseManager", foreign_key: "manager_id",
  								dependent: :destroy
  has_many :managed_courses, through: :manage_course_rel, source: :course
  def deal_course(some_course, type)
  	if(!self.dealt_a?(some_course))
  		case type
  		when 0
  			admin_course_rel.create(course_id: some_course.id)
  		when 1
  			manage_course_rel.create(course_id: some_course.id)
  		end
  	end
  end
  def not_deal_course(some_course, type)
  	if(self.dealt_a?(some_course))
  		case type
	  	when 0
	  		admin_course_rel.find_by(course_id: some_course.id).destroy
	  	when 1
	  		manage_course_rel.find_by(course_id: some_course.id).destroy
	  	end
  	end
  end
  def dealt_a_course?(some_course, type)
  	case type
  	when 0
  		return admined_courses.include?(some_course)
  	when 1
  		return managed_courses.include?(some_course)
  	end
  end

  # draft method to redirect to PayPal payment
	def paypal_url(root, return_path, sponsor_amount, name, event_id)
		values = {
				business: "csc444.toronto-merchant@gmail.com", #created an account on PayPal Developer and fake Sandbox email addresses
				cmd: "_xclick",
        return: "#{root}hook",
				# return: "#{root}#{return_path}",
        rm: 2,
				amount: sponsor_amount,
				item_name: "Sponsor a tournament #{name}",
        item_number: event_id,
        currency_code: "CAD",
        notify_url: "#{root}hook"
		}
		"#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
	end

end
