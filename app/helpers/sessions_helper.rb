module SessionsHelper
	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id] 
	end
	def require_user
		redirect_to '/login' unless current_user 
	end
    def require_organizer
        @tournament = Tournament.find(params[:id])
        redirect_to "/tournaments" unless (!current_user.nil? && @tournament.got_organizer?(current_user))
    end
    def require_player
        @tournament = Tournament.find(params[:id])
        redirect_to "/tournaments" unless (!current_user.nil? && @tournament.got_player?(current_user))
    end
    def require_sponsor
    	@tournament = Tournament.find(params[:id])
        redirect_to "/tournaments" unless (!current_user.nil? && @tournament.got_sponsor?(current_user))
    end
	
	def log_in(user)
    	session[:user_id] = user.id
	end
	def log_out(user)
		session[:user_id] = nil
	end
	def logged_in?
    	!(current_user.nil?)
  	end
end
