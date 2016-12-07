class AddDescriptionAndTypeToTournaments < ActiveRecord::Migration[5.0]
  def change
  	add_column :tournaments, :description, :text, limit: 500
  	add_column :tournaments, :tournament_type, :integer
  end
end
