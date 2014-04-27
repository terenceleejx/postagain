class AddSentTime < ActiveRecord::Migration
  def change
  	add_column :users, :sent_at, :integer
  end
end
