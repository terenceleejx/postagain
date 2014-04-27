class TweakPostColumn < ActiveRecord::Migration
  def change
  	remove_column :users, :sent_at
  	add_column :posts, :sent_at, :integer
  end
end
