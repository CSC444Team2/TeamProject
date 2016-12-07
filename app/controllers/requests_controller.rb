class RequestsController < ApplicationController
	def new
		if current_user.nil?
			redirect_to login_path
		else
			@request=Request.new
			@candidate_events = Tournament.all
			#Do not include events that the user already organizes
			@candidate_events = @candidate_events.reject do |t|
				t.got_organizer?(current_user)
			end

			#Default selection
			@selected_event=params[:selected_event]
			if @selected_event.nil? && !@candidate_events.empty?
				@selected_event=1
			end
		end
	end
	def create
		@request=Request.new(request_params)
		if !current_user.nil?
			@request.sender_id=current_user.id
			if(!@request.save)
				render "new"
			else
				@tournament=Tournament.find(@request.receiver_id)
				redirect_to tournament_path(@tournament)
			end
		else
			redirect_to login_path
		end
	end
	def destroy
		@request = Request.find(params[:id])
		if(!(@request.nil?))
			@sender=User.find(@request.sender_id)
			@event=Tournament.find(@request.receiver_id)
			if(params[:approval]=="1")
				@sender.organize_a(@event)
			end
			@request.destroy
			redirect_to tournament_path(@event)
		end
	end

	private
    def request_params
        params.require(:request).permit(:receiver_id, :message)
    end
end
