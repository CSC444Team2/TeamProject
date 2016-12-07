class TournamentsController < ApplicationController
    before_action :require_user, only: [:new, :create]
    before_action :private_permission, only: [:show]
    before_action :require_organizer, only: [:edit, :update, :destroy]
    protect_from_forgery except: [:hook_sponsor, :hook_play]

    def index
        @tournaments = Tournament.all
    end

    def show
        @tournament = Tournament.find(params[:id])
        @is_organizer = current_user && current_user.organized_a?(@tournament)
        @unassigned_players = []
        @unassigned_dump = []
        @group_of_groups = []
        @group_id = []
        if @tournament.players.any?
            @tournament.players.each do |p|
                @unassigned_players << p
            end
            @tournament.player_groups.each do |pg|
                @players_in_group = []
                @group_id << pg.id
                pg.group_members.each do |usr_id|
                    @user= User.find(usr_id)
                    @players_in_group << @user
                    @unassigned_players = @unassigned_players.reject do |p|
                        p==@user
                    end
                end
                @group_of_groups << { id: pg.id, players: @players_in_group }
            end
            @unassigned_players.each do |p|
                @unassigned_dump << [p.id.to_s+". "+p.first_name+" "+p.last_name+"("+p.email+")", p.id]
            end
        end #end if

        if !@tournament.golf_course_id.nil?
            @golf_course = GolfCourse.find(@tournament.golf_course_id)
        end

        @google_api_key = google_api_key
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
        if !@tournament.nil?
            @tournament.destroy
        end
        redirect_to tournaments_path
    end

    def create_group
        if !params[:id].nil? && !params[:id].empty?
            @tournament = Tournament.find(params[:id])
            if !@tournament.nil? && current_user && current_user.organized_a?(@tournament)
                Playergroup.create(tournament_id: @tournament.id)
                redirect_to tournament_path(@tournament)
            end
        end
    end

    def delete_group
        if !params[:group_id].nil? && !params[:group_id].empty? && !params[:id].nil? && !params[:id].empty?
            @tournament = Tournament.find(params[:id])
            if !@tournament.nil? && current_user && current_user.organized_a?(@tournament)
                @pg = Playergroup.find(params[:group_id])
                @pg.destroy
                redirect_to tournament_path(@tournament)
            end
        end
    end

    def add_member
        if !params[:tournament_id].nil? && !params[:tournament_id].empty? && !params[:group_id].nil? && !params[:group_id].empty? && !params[:added_member].nil? && !params[:added_member].empty?
            @tournament = Tournament.find(params[:id])
            @group = Playergroup.find(params[:group_id])
            @member = User.find(params[:added_member])
            if !@tournament.nil? && !@group.nil? && !@member.nil?
                if current_user && current_user.organized_a?(@tournament)
                    @group.add_member(@member)
                    @group.save
                end
                redirect_to tournament_path(@tournament)
            end
        end
    end

    def member_out_of_group
        @member = User.find(params[:member])
        @tournament = Tournament.find(params[:id])
        if !@member.nil? && !@tournament.nil? && current_user && current_user.organized_a?(@tournament)
            @tournament.player_groups.each do |pg|
                if pg.has_member?(@member)
                    pg.remove_member(@member)
                    pg.save
                    if pg.num_members == 0
                        pg.destroy
                    end
                end
            end
            redirect_to tournament_path(@tournament)
        end
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
    
    def hook_sponsor
      params.permit! # Permit all Paypal input params
      status = params[:payment_status]
      if status == "Completed"
        @tournament = Tournament.find(params[:item_number])
        current_user.sponsor_a(@tournament)
        redirect_to(:action => 'show', :id => @tournament.id)
      else
        render nothing: true
      end
    end

    def hook_play
      params.permit! # Permit all Paypal input params
      status = params[:payment_status]
      amount = params[:mc_gross]
      if status == "Completed"
        @tournament = Tournament.find(params[:item_number])
        current_user.play_in(@tournament)
        if amount == @tournament.price
            @ticket = Ticket.create(user_id: current_user.id, tournament_id: @tournament.id, tickets_type: 'Play')
        else
            @ticket = Ticket.create(user_id: current_user.id, tournament_id: @tournament.id, tickets_type: 'Play & Eat')
        end
        redirect_to controller: "tickets", action: "show", id: @ticket.id
      else
        render nothing: true
      end
    end
    
    private
    def tournament_params
        params.require(:tournament).permit(:name, :id, :location, :date, :contact_email, :contact_name, :description, :is_private, :golf_course_id, :price)
    end

    def private_permission
        @tournament = Tournament.find(params[:id])
        if @tournament && @tournament.is_private!=0
            if current_user
                return true
            else
                redirect_to '/'
            end
        end
    end
end
