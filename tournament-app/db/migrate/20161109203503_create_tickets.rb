class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.belongs_to :tournament, index: true
      t.belongs_to :user, index: true
      t.string :tickets_type
      t.timestamps
    end
  end
end
