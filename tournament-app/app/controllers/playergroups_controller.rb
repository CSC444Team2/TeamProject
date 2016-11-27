class PlayergroupsController < ApplicationController
    def create_group
        @members = params[:members]
        if !@members.nil?
            @group=@tournament.new_group
            @members.each do |m|
                @group.add_member(m)
            end
        end
    end

    def add_member
        @group = params[:group]
        @member = params[:member]
        if !@group.nil? && !@member.nil?
            @group.add_member(@member)
        end
    end
end