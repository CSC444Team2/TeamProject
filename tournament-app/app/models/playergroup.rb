class Playergroup < ApplicationRecord
	belongs_to :member, class_name: "User"
	belongs_to :event, class_name: "Tournament"
	serialize :group_members, Array

	validate :members_exist
	validate :unique_members
	gvalidate :right_size
	def members_exist
		@all_user_ids=User.all.pluck(:id) #get all user ids
		if !group_members.is_a?(Array) || 
			!(group_members.all? { |u| @all_user_ids.include?(u) })
			errors.add(:group_members, :members_invalid)
		endp
	end

	def unique_members
		if group_members.uniq.length != group_members.length
			errors.add(:group_members, :duplicate_members)
		end
	end

	def right_size
		if group_members.length>4
			errors.add(:group_members, :too_many_members)
		end
	end
end
