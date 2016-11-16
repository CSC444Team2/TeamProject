class JoinController < ApplicationController
	before_action :require_user
	def create
		@event = Tournament.find(params[:event_id])
		@joinType = params[:join].to_i
		if !current_user.nil? && !@joinType.nil? && @joinType >= 0 && @joinType < 3
			case @joinType
			when 0
				if !current_user.played_in?(@event)
    				current_user.play_in(@event)
                    redirect_to tournament_path(@event)
    			end
    		when 1
    			if !current_user.organized_a?(@event)
                    redirect_to new_request_path
    			end
    		when 2
    			if !current_user.sponsored_a?(@event)
    				current_user.sponsor_a(@event)
                    redirect_to tournament_path(@event)
    			end
    		else
    			redirect_to tournament_path(@event)
    		end
    	end
	end
	def destroy
		@event = Tournament.find(params[:event_id])
		@joinType = params[:join].to_i
		if !current_user.nil? && !@joinType.nil? && @joinType >= 0 && @joinType < 3
			case @joinType
			when 0
				if current_user.played_in?(@event)
    				current_user.not_play(@event)
    			end
    		when 1
    			if current_user.organized_a?(@event)
    				current_user.not_organize(@event)
    			end
    		when 2
    			if current_user.sponsored_a?(@event)
    				current_user.not_sponsor(@event)
    			end
    		else
    			redirect_to tournament_path(@event)
    		end
		end
		redirect_to tournament_path(@event)
	end
end
