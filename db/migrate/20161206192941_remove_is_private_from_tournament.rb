class RemoveIsPrivateFromTournament < ActiveRecord::Migration[5.0]
  def change
    remove_column :tournaments, :is_private, :integer
    add_column :tournaments, :is_private, :integer
  end
end
