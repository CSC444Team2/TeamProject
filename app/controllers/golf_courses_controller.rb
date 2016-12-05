      class GolfCoursesController < ApplicationController
	before_action :require_user, only: [:new, :create, :edit, :update, :destroy]
	def index
		@golf_courses = GolfCourse.all
	end

	def show
		@golf_course = GolfCourse.find(params[:id])
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
		if @golf_course.save
			redirect_to golf_course_path(@golf_course)
		else
			render 'new'
		end
	end

	def destroy
		@golf_course = GolfCourse.find(params[:id])
		@golf_course.destroy
		redirect_to golf_courses_path
	end

	private
	def golf_course_params
		params.require(:golf_course).permit(:name, :overview, :address, :website, :contact_info)
	end
end
