class PlayerGroup < ActiveRecord::Base
	belongs_to :tournament
	has_many :users
end
