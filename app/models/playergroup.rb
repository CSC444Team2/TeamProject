class Playergroup < ApplicationRecord
	belongs_to :event, class_name: "Tournament"
	serialize :group_members, Array

	validates :tournament_id, presence: true
	validate :members_valid
	validate :unique_members
	validate :right_size

	def add_member(user)
		if !user.nil? && !group_members.include?(user.id)
			group_members << user.id
		end
	end
	def remove_member(user)
		if !user.nil? && group_members.include?(user.id)
			group_members.delete(user.id)
		end
	end
	def has_member?(user)
		if !user.nil?
			return group_members.include?(user.id)
		else
			return false
		end
	end
	def num_members
		return group_members.length
	end

	def members_valid
		@all_user_ids=User.all.pluck(:id) #get all user ids
		if !group_members.is_a?(Array) || 
			!(group_members.all? { |u| @all_user_ids.include?(u) })
			errors.add(:group_members, :members_invalid)
		end
	end
	def unique_members
		if group_members.uniq.length != group_members.length
			errors.add(:group_members, :duplicate_members)
		end
	end
	def right_size
		if group_members.length>4
			errors.add(:group_members, :cannot_have_more_than_4_members)
		end
	end
end
