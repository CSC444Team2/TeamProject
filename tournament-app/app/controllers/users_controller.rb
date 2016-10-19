class UsersController < ApplicationController
	#http_basic_authenticate_with name: "admin", password: "admin", except: [:index, :show]
	#before_action :require_user, only: [:index, :show]
	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
  	end

  	def edit
  		@user = User.find(params[:id])
  	end

	def create
		@user = User.new(user_params)

		if @user.save
			log_in(@user)
			redirect_to @user
		else
			render 'new'
		end
	end

	def update
  		@user = User.find(params[:id])
 
  		if @user.update(user_params)
    		redirect_to @user
  		else
    		render 'edit'
  		end
	end

	def destroy
  		@user = User.find(params[:id])
  		@user.destroy
 
  		redirect_to users_path
	end

	def played_events
		@title = "Played Events"
		@person = User.find(params[:id])
		@events = @person.played_events#.paginate(page: params[:page])
		render "events_one_person"
	end

	def organized_events
		@title = "Organized Events"
		@person = User.find(params[:id])
		@events = @person.organized_events#.paginate(page: params[:page])
		render "events_one_person"
	end

	def sponsored_events
		@title = "Sponsored Events"
		@person = User.find(params[:id])
		@events = @person.sponsored_events#.paginate(page: params[:page])
		render "events_one_person"
	end

	private
		def user_params
			params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
		end
end
