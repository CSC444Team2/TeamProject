class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :first_name
      t.text :last_name
      #t.int :age
      #t.text :email
      t.references :tournament, foreign_key: true

      t.timestamps null: false
    end
  end
end
