class GolfRequestsController < ApplicationController
	def new
		if current_user.nil?
			redirect_to login_path
		else
			@golf_request_type = params[:golf_request_type].to_i
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
		end
	end

	def create
		#render "test"
		@request=GolfRequest.new(request_params)
		if !current_user.nil?
			@request.sender_id=current_user.id
			if(!@request.save)
				render "new"
			else
				@golf_course=GolfCourse.find(@request.receiver_id)
				redirect_to golf_course_path(@golf_course)
			end
		else
			redirect_to login_path
		end
	end

	def destroy
		@request = GolfRequest.find(params[:id].to_i)
		if(!(@request.nil?))
			@sender=User.find(@request.sender_id)
			@course=GolfCourse.find(@request.receiver_id)
			if(params[:approval]=="1" && @request.valid?)
				@sender.deal_course(@course, @request.golf_request_type)
			end
			@request.destroy
			redirect_to golf_course_path(@course)
		end
	end

	private
    def request_params
        params.require(:golf_request).permit(:receiver_id, :message, :golf_request_type)
    end
end
