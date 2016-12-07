class UsersController < ApplicationController
	http_basic_authenticate_with name: "admin", password: "admin", only: [:index]
	before_action :is_user_profile, except: [:index, :new, :create, :show]
	before_action :require_user, only: [:index, :show]

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
			@user.send_confirmation
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
  		log_out(@user)
  		@user.destroy
 
  		redirect_to users_path
	end

	def played_events
		@title = "Played Tournaments"
		@person = User.find(params[:id])
		@events = @person.played_events#.paginate(page: params[:page])
		render "_show_events_for_one_person"
	end

	def organized_events
		@title = "Organized Tournaments"
		@person = User.find(params[:id])
		@events = @person.organized_events#.paginate(page: params[:page])
		render "_show_events_for_one_person"
	end

	def sponsored_events
		@title = "Sponsored Tournaments"
		@person = User.find(params[:id])
		@events = @person.sponsored_events#.paginate(page: params[:page])
		render "_show_events_for_one_person"
	end

	private
		def user_params
			params.require(:user).permit(:first_name, :last_name, :gender, :date_of_birth, :phone_number, :address, :email, :password, :password_confirmation, :profile_picture)
		end
		def is_user_profile
			@user = User.find(params[:id])
			if !current_user || @user.id!=session[:user_id]
				redirect_to "/"
				return false
			else
				return true
			end
		end
end
