class TicketsController < ApplicationController
	before_action :require_user
	def create
		@event_id = params[:ticket][:event_id]
		@ticket_type = params[:ticket][:tickets_type]
		if !@event_id.nil? && !@ticket_type.nil?
			@event = Tournament.find(@event_id)
			if !@event.nil?
				@ticket = Ticket.new(tournament_id: @event_id, user_id: current_user.id, tickets_type: @ticket_type)
			end
		end
		if @ticket.save
			redirect_to @ticket
		else
			render test
		end
	end

	def new
		@event_id = params[:event_id]
		@event = Tournament.find(params[:event_id])
		@payment = params[:payment]
		@tournament_name = @event.name
		@username = current_user.get_user_name
		@ticket = Ticket.new(tournament: @event, user: current_user)
	end

	def show
    @ticket = Ticket.find(params[:id])
    @event = Tournament.find(@ticket.tournament_id)
    @event_name = Tournament.find(@ticket.tournament_id).name
    @user_name = current_user.get_user_name
  end

	def destroy
  end

end
