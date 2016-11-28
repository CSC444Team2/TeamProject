class TournamentsController < ApplicationController
    before_action :require_user, only: [:new, :create, :edit, :update, :destroy]
    before_action :require_organizer, only: [:edit, :update, :destroy]
    protect_from_forgery except: [:hook]

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
                @group_of_groups << @players_in_group
            end
            @unassigned_players.each do |p|
                @unassigned_dump << [p.id.to_s+". "+p.first_name+" "+p.last_name+"("+p.email+")", p.id]
            end
        end #end if
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

    def create_group
        @members = params[:members]
        if !@members.nil?
            @group=@tournament.new_group
            @members.each do |m|
                @group.add_member(m)
            end
            redirect_to tournament_path(@tournament)
        end
    end

    def add_member
        @group = params[:group]
        @member = params[:member]
        if !@group.nil? && !@member.nil?
            @group.add_member(@member)
        end
    end

    def member_out_of_group
        @member = User.find(params[:member].to_i)
        @tournament = Tournament.find(params[:id].to_i)
        if !@member.nil? && !@tournament.nil?
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
    
    def hook
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
    
    private
    def tournament_params
        params.require(:tournament).permit(:name, :id, :location, :date, :contact_email, :contact_name, :description)
    end
end
