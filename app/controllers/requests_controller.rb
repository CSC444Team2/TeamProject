class RequestsController < ApplicationController
	def new
		
		if current_user.nil?
			redirect_to login_path
		else
			@is_golf_course = params[:is_golf_course]
			if !@is_golf_course.nil?
				@golf_request_type = params[:golf_request_type]
				@request=GolfRequest.new(golf_request_type: @golf_request_type)
				@candidate_courses = GolfCourse.all
				@candidate_courses = @candidate_courses.reject do |g|
					if @golf_request_type == 0
						g.got_admin?(current_user)
					elsif @golf_request_type == 1
						g.got_csr?(current_user)
					end
				end

				@selected_course = params[:selected_course]
				if @selected_course.nil? && !@candidate_courses.empty?
					@selected_course = 1
				end
			else
				@request=Request.new
				@candidate_events = Tournament.all
				#Do not include events that the user already organizes
				@candidate_events = @candidate_events.reject do |t|
					t.got_organizer?(current_user)
				end

				#Default selection
				@selected_event=params[:selected_event]
				if @selected_event.nil? && !@candidate_events.empty?
					@selected_event=1
				end
			end
		end
	end
	def create
		@request=Request.new(request_params)
		if !current_user.nil?
			@request.sender_id=current_user.id
			if(!@request.save)
				render "new"
			else
				@tournament=Tournament.find(@request.receiver_id)
				redirect_to tournament_path(@tournament)
			end
		else
			redirect_to login_path
		end
	end
	def destroy
		@request = Request.find(params[:id])
		if(!(@request.nil?))
			@sender=User.find(@request.sender_id)
			@event=Tournament.find(@request.receiver_id)
			if(params[:approval]=="1")
				@sender.organize_a(@event)
			end
			@request.destroy
			redirect_to tournament_path(@event)
		end
	end

	private
    def request_params
        params.require(:request).permit(:receiver_id, :message)
    end
end
