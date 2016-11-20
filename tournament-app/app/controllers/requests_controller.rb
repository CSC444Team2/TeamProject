class RequestsController < ApplicationController
	def new
		@request=Request.new
		if current_user.nil?
			redirect_to login_path
		end
	end
	def create
		@request=Request.new(request_params)
		if !current_user.nil?
			@request.sender_id=current_user.id
			if(!@request.save)
				render "new"
			else
				redirect_to tournament_path(@tournament)
			end
		else
			redirect_to login_path
		end
	end
	def destroy
		@request = Request.find(params[:request_id])
		if(!(@request.nil?))
			@sender=User.find(@request.sender_id)
			@event=Tournament.find(@request.receiver_id)
			if(params[:approve]==true)
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
