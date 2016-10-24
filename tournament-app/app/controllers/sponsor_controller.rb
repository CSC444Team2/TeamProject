class SponsorController < ApplicationController
	before_action :require_user
	def create
		@event = Tournament.find(params[:event_id])
		if !current_user.nil? && !current_user.sponsored_a?(@event)
    		current_user.sponsor_a(@event)
    	end
    	redirect_to tournament_path(@event)
	end
	def destroy
		@event = Tournament.find(params[:id])
		if !current_user.nil? && current_user.sponsored_a?(@event) 
			current_user.not_sponsor(@event)
		end
		redirect_to tournament_path(@event)
	end
end
