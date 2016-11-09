class RemoveTypeFromTournaments < ActiveRecord::Migration[5.0]
  def change
    remove_column :tournaments, :type, :boolean
    remove_column :tournaments, :tournament_type, :integer
  end
end
