class Tournament < ActiveRecord::Base
	has_one :player_group
end
