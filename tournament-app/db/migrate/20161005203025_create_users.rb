class CreateUsers < ActiveRecord::Migration
  def change
      # drop_table :users
    create_table :users do |t|
      t.text :first_name #string
      t.text :last_name

      t.text :email
      # t.references :tournament, foreign_key: true

      t.timestamps
    end
  end
end
