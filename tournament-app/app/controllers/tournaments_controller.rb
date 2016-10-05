class TournamentsController < ApplicationController
    def index
        @tournaments = Tournament.all
    end
    def show
        @tournament = Tournament.find(params[:id])
    end
    def edit
        @tournament = Tournament.find(params[:id])
    end
    def update
        @tournament = Tournament.find(params[:id])
        if @tournament.update_attributes(tournament_params)
            redirect_to(:action => 'show', :id => @tournament.id)
        else
            render 'edit'
        end
    end
    def new
        @tournament = Tournament.new
    end
    
    def create
        @tournament=Tournament.new(tournament_params)
        if @tournament.save
            redirect_to tournament_path(@tournament) #may change later '/tournaments'
        else
            render 'new'
        end
    end
    
    private
    def tournament_params
        params.require(:tournament).permit(:name, :id)
    end
end
