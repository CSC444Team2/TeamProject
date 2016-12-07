class JoinController < ApplicationController
	before_action :require_user
	def create
		@event = Tournament.find(params[:event_id])
		@joinType = params[:join].to_i
		if !current_user.nil? && !@joinType.nil? && @joinType >= 0 && @joinType < 3
			case @joinType
			when 0
				if !current_user.played_in?(@event)
    				# current_user.play_in(@event)
                    redirect_to current_user.paypal_url(root_url, 'play', params[:sponsor_amount], params[:name], params[:event_id])
    			end
    		when 1
    			if !current_user.organized_a?(@event)
                    redirect_to new_request_path(selected_event: @event.id, is_golf_course: false)
    			end
    		when 2
    			if !current_user.sponsored_a?(@event)
                    redirect_to current_user.paypal_url(root_url, 'sponsor', params[:sponsor_amount], params[:name], params[:event_id])
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
                    Playergroup.all.each do |pg|
                        if pg.tournament_id==@event.id && pg.has_member?(current_user)
                            pg.remove_member(current_user)
                            pg.save
                        end
                    end
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
