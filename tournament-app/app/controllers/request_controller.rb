class RequestController < ApplicationController
	def destroy
		@request = Request.find(params[:request_id])
		if(!(@request.nil?))
			@request.destroy
	end
end
