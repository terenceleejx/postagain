class AddResentCount < ActiveRecord::Migration
  def change
  	add_column :posts, :resent, :integer, default: 0
  end
end
