class PlayController < ApplicationController
	before_action :require_user
	def create
		@event = Tournament.find(params[:event_id])
		if !current_user.nil? && !current_user.played_in?(@event)
    		current_user.play_in(@event)
    	end
    	redirect_to tournament_path(@event)
	end
	def destroy
		@event = Tournament.find(params[:id])
		if !current_user.nil? && current_user.played_in?(@event)
			current_user.not_play(@event)
		end
		redirect_to tournament_path(@event)
		
	end
end
