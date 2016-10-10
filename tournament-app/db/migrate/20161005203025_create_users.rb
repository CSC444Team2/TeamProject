class CreateUsers < ActiveRecord::Migration
  def change
      # drop_table :users
    create_table :users do |t|
      t.string :name
      t.string :email
      # t.references :tournament, foreign_key: true

      t.timestamps
    end
  end
end
