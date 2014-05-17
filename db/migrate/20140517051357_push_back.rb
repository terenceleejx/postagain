class PushBack < ActiveRecord::Migration
  def change
  	remove_column :posts, :resent
  	add_column :posts, :pushback, :date
  end
end
