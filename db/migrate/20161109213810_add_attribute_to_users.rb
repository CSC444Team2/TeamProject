class AddAttributeToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :date_of_birth, :date
  	add_column :users, :phone_number, :integer
  	add_column :users, :gender, :string
  	add_column :users, :address, :string
  end
end
