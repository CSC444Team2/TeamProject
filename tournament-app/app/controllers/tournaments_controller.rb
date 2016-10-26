class TournamentsController < ApplicationController
    before_action :require_user, only: [:new, :create, :edit, :update, :destroy]
    before_action :require_organizer, only: [:edit, :update, :destroy]
    
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
        @organizer = current_user
        @organizer.organize_a(@tournament)
    end
    
    def create
        @tournament=Tournament.new(tournament_params)
        @curr_user = current_user
        if !@curr_user.nil? && @tournament.save
            @curr_user.organize_a(@tournament)
            redirect_to tournament_path(@tournament) #may change later '/tournaments'
        else
            render 'new'
        end
    end

    def destroy
        @tournament = Tournament.find(params[:id])
        @tournament.destroy
        redirect_to tournaments_path
    end

    def players
        @title = "Players"
        @event = Tournament.find(params[:id])
        @persons = @event.players#.paginate(page: params[:page])
        render "_show_persons_for_one_event"
    end

    def organizers
        @title = "Organizers"
        @event = Tournament.find(params[:id])
        @persons = @event.organizers#.paginate(page: params[:page])
        render "_show_persons_for_one_event"
    end

    def sponsors
        @title = "Sponsors"
        @event = Tournament.find(params[:id])
        @persons = @event.sponsors#.paginate(page: params[:page])
        render "_show_persons_for_one_event"
    end
    
    private
    def tournament_params
        params.require(:tournament).permit(:name, :id, :location, :date, :contact_email, :contact_name)
    end
end
