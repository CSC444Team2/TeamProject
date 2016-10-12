module SessionsHelper
	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id] 
	end
	def require_user
		redirect_to '/login' unless current_user 
	end
	
	def log_in(user)
    	session[:user_id] = user.id
	end
	def logged_in?
    	!(@current_user.nil?)
  	end
end
