class GolfCoursesController < ApplicationController
	before_action :require_user, only: [:new, :create, :operate_course, :stop_operate]
	before_action :is_course_admin, only: [:edit, :update, :destroy]
	def index
		@golf_courses = GolfCourse.all
	end

	def show
		@golf_course = GolfCourse.find(params[:id])
		@is_admin = current_user && current_user.dealt_a_course?(@golf_course, 0)
		@is_manager = current_user && current_user.dealt_a_course?(@golf_course, 1)
		@hosted_tournaments = []
		Tournament.all.each do |t|
			if t.golf_course_id == @golf_course.id
				@hosted_tournaments << t
			end
		end

		@google_api_key = google_api_key
	end

	def edit
		@golf_course = GolfCourse.find(params[:id])
	end

	def update
		@golf_course = GolfCourse.find(params[:id])
		if @golf_course.update_attributes(golf_course_params)
            redirect_to(:action => 'show', :id => @golf_course.id)
        else
            render 'edit'
        end
	end

	def new
		@golf_course = GolfCourse.new
	end
	def create
		@golf_course = GolfCourse.new(golf_course_params)
		if current_user && @golf_course.save
			current_user.deal_course(@golf_course, 0)
			redirect_to golf_course_path(@golf_course)
		else
			render 'new'
		end
	end

	def destroy
		@golf_course = GolfCourse.find(params[:id])
		if @golf_course
			@golf_course.destroy
		end
		redirect_to golf_courses_path
	end

	#Admin & Manager
	def operate_course
		@golf_course = GolfCourse.find(params[:golf_course_id])
		@joinType = params[:join].to_i
		if !current_user.nil? && current_user.dealt_a_course?(@golf_course, 0) && @joinType==1
			current_user.deal_course(@golf_course, 1)
			redirect_to golf_course_path(@golf_course)
		elsif !current_user.nil? && !@joinType.nil? && @joinType >= 0 && @joinType <= 1
			if !current_user.dealt_a_course?(@golf_course, @joinType)
				redirect_to new_golf_request_path(selected_course: @golf_course.id, golf_request_type: @joinType)
				#current_user.deal_course(@golf_course, @joinType)
                #redirect_to golf_course_path(@golf_course)
			end
    	end
	end
	
	def stop_operate
		@golf_course = GolfCourse.find(params[:golf_course_id])
		@joinType = params[:join].to_i
		if !current_user.nil? && !@joinType.nil? && @joinType >= 0 && @joinType <= 1
			if current_user.dealt_a_course?(@golf_course, @joinType)
				current_user.not_deal_course(@golf_course, @joinType)
                redirect_to golf_course_path(@golf_course)
			end
    	end
	end

	private
	def golf_course_params
		params.require(:golf_course).permit(:name, :overview, :address, :website, :contact_info)
	end
	def is_course_admin
		return current_user && current_user.dealt_a_course?(@golf_course, 0)
	end
end
