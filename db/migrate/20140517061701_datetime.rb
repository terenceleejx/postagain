class Datetime < ActiveRecord::Migration
  def change
  	remove_column :posts, :pushback
  	add_column :posts, :pushback, :datetime
  end
end
