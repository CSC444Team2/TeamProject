class PlayerGroupsController < ApplicationController
	def create
		@player_group = Player_group.find(params[:player_group_id])
		@user = @player_group.users.create(user_params)
		redirect_to player_group_path(@player_group)
	end

	def destroy
		@player_group = Player_group.find(params[:player_group_id])
		@user = @player_group.users.find(params[:id])
		@user.destroy
		redirect_to player_group_path(@player_group)
	end

	private
		def user_params
			params.require(:user).permit(:first_name, :last_name)
		end
end
