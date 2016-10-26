class AddAttributesToTournament < ActiveRecord::Migration[5.0]
  def change
    add_column :tournaments, :date, :datetime
    add_column :tournaments, :contact_email, :string
    add_column :tournaments, :contact_name, :string
  end
end
