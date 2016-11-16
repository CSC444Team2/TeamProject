class RequestsController < ApplicationController
	def new
		@request=Request.new
		if current_user.nil?
			redirect_to login_path
		end
	end
	def create
		@request=Request.new(sender_id: current_user.id, receiver_id: params[:receiver_id], message: params[:message])
		if !current_user.nil?
			@tournament=Tounament.find_by(params[receiver_id])
			if(!@tournament.nil)
				current_user.sent_requests << @request
				redirect_to tournament_path(@tournament)
			end
		else
			redirect_to login_path
		end
	end
	def destroy
		@request = Request.find(params[:request_id])
		if(!(@request.nil?))
			@request.destroy
		end
	end
end
