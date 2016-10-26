class AddResetToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :reset_digest, :string
    add_column :users, :reset_sent_at, :datatime
  end
end
