class AddDeletePostColumn < ActiveRecord::Migration
  def change
  	add_column :posts, :delete, :boolean, default: false
  end
end
