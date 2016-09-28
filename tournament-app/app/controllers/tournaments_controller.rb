class TournamentsController < ApplicationController
    def index
            @tournaments = Tournament.all
    end
    def new
        
    end
end
