class AddTypeToTournament < ActiveRecord::Migration[5.0]
  def change
    add_column :tournaments, :type, :boolean
  end
end
