class AddLocationToTouranament < ActiveRecord::Migration[5.0]
  def change
  	add_column :tournaments, :location, :string
  end
end
