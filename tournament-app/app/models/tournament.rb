class Tournament < ActiveRecord::Base
	has_one :player_groups
end
